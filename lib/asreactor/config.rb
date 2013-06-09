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

module ASReactor
  class Config
    # @param filename [String]
    # @return [ASReactor::Config]
    def self.load(filename)
      self.new(YAML.load_file(filename))
    end

    # @param data [Hash]
    # @return [ASReactor::Config]
    def initialize(data)
      @data = data.dup
      #$stderr.puts @data.inspect
    end

    # @param key [String]
    def [](key)
      @data[key.to_s]
    end

    # @param key [String]
    def []=(key, value)
      @data[key.to_s] = value
    end
  end
end
