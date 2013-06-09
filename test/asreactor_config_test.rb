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

require File.expand_path '../test_helper.rb', __FILE__

describe 'ASReactor::Config' do
  before do
    @config = ASReactor::Config.load(TEST_CONFIG_FILE)
  end

  it 'should load a configuration file' do
    assert_instance_of ASReactor::Config, @config
  end

  it 'should return config items' do
    # This makes assumptions about the contents of TEST_CONFIG_FILE.
    assert_instance_of String, @config['region']
    assert_instance_of String, @config['topic_arn']
    assert_instance_of Array, @config['groups']
  end
end
