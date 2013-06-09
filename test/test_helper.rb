# Copyright 2013 Nick Osborn.
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

require 'minitest/spec'
require 'minitest/autorun'

require 'coveralls'
Coveralls.wear!

require 'asreactor'

AWS.eager_autoload!
AWS.stub!

TEST_CONFIG_FILE = File.expand_path('../asreactor_test.yml', __FILE__)