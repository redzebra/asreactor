# Copyright 2013 Nick Osborn.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'aws-sdk'
require 'uuidtools'

module ASReactor
  class Listener
    def initialize
      @groups = ASReactor.config['groups'].map do |group|
        group.merge({'name_regexp' => /^#{Regexp.escape(group['name']).sub('\*','.*')}$/})
      end
      @region = ASReactor.config['region']

      @auto_scaling = AWS::AutoScaling.new(:region => @region)
      @sns = AWS::SNS.new(:region => @region)
      @sqs = AWS::SQS.new(:region => @region)

      @queue = create_queue
      at_exit { @queue.delete }

      @subscription = subscribe(@queue)
      at_exit { @subscription.unsubscribe }
    end

    def run
      opts = {
        :wait_time_seconds => 20,
        :attributes => [:sender_id, :sent_at]
      }
      @queue.poll(opts) do |message|
        ASReactor.log.info 'message %s sent %s by %s' % [
          message.id, message.sent_at.utc.iso8601, message.sender_id
        ]
        ASReactor.log.debug 'message= '+message.inspect
        begin
          activity = message.as_sns_message.body_message_as_h
        rescue JSON::ParserError
          ASReactor.log.error 'malformed message %s sent %s by %s' % [
            message.id, message.sent_at.utc.iso8601, message.sender_id
          ]
          next
        end
        ASReactor.log_debug 'activity= '+activity.inspect
        react_to(activity)
      end
    end

    private

    # @return [AWS::SQS::Queue]
    def create_queue
      options = {
        :message_retention_period => 600, # discard after 10 minutes
        :visibility_timeout => 10,  # redliver after 10 seconds
      }
      begin
        queue_name = "asreactor-#{UUIDTools::UUID.timestamp_create}"
        @sqs.queues.create(queue_name, options)
      rescue AWS::SQS::Errors::QueueDeletedRecently => e
        ASRespond.log.error e.inspect
        retry
      end
    end

    # @param queue [AWS::SQS::Queue]
    # @return [AWS::SNS::Subscription]
    def subscribe(queue)
      topic_arn = ASReactor.config['topic_arn']
      topic = @sns.topics[topic_arn]
      topic.subscribe(queue)
    end

    # @param activity[Hash]
    def react_to(activity)
      env ||= {'ASREACT_REGION' => @region}.merge(Hash[
        activity.to_a.map {|k, v| ["ASREACT_#{k.gsub(/([0-9a-z])([A-Z])/,'\1_\2').upcase}", v.to_s]}
      ])
     ASRector.log.debug 'env= '+env.inspect

      @groups.select do |group|
        if activity['AutoScalingGroupName'] =~ group['name_regexp']
          ASReactor.log.debug 'spawning '+group['exec'].inspect+' for '+activity['AutoScalingGroupName'].inspect
          begin
            pid = spawn(env, group['exec'], :unsetenv_others => true, :in => :close)
            ASReactor.log.debug 'disowning pid '+pid.inspect
            Process.detach(pid)
          rescue Errno::ENOENT => e
            ASRector.log.error e.message
          end
        end
      end
    end
  end
end
