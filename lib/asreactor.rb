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

require 'asreactor/version'

require 'asreactor/config'
require 'aws-sdk'
require 'logger'

module ASReactor
  @debug = false
  @log_level = Logger::INFO
  @verbose = false

  # @param filename [String]
  # @return [ASReactor::Config]
  def self.config
    @config ||= ASReactor::Config.load(config_file)
  end

  def self.config_file
    @config_file
  end

  def self.config_file=(value)
    @config_file = value
  end

  def self.debug
    @debug
  end

  def self.debug=(value)
    @debug = value
    @log_level = @debug ? Logger::DEBUG : Logger::INFO
  end

  def self.verbose
    @verbose
  end

  def self.verbose=(value)
    @verbose = value
  end

  def self.log
    @log ||= Logger.new(STDERR)
    @log.level = @log_level
    @log
  end
end

require 'asreactor/listener'
