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

describe 'ASReactor' do
  it 'should allow the config file to be set' do
    config_file_name = '/config/asreactor.'+Time.now.to_i.to_s+'.yml'
    ASReactor.config_file = config_file_name
    assert_equal ASReactor.config_file, config_file_name
  end

  it 'should not default to debug mode' do
    assert_equal ASReactor.debug, false
  end
  it 'should allow debug mode to be set' do
    ASReactor.debug = true
    assert_equal ASReactor.debug, true
    ASReactor.debug = false
    assert_equal ASReactor.debug, false
  end

  it 'should not default to verbose mode' do
    assert_equal ASReactor.verbose, false
  end
  it 'should allow verbose mode to be set' do
    ASReactor.verbose = true
    assert_equal ASReactor.verbose, true
    ASReactor.verbose = false
    assert_equal ASReactor.verbose, false
  end

  it 'should provide a logger' do
    assert_instance_of Logger, ASReactor.log
  end

  it 'should load a configuration file' do
    ASReactor.config_file = TEST_CONFIG_FILE
    assert_instance_of ASReactor::Config, ASReactor.config
  end
end
