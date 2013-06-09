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

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asreactor/version'

Gem::Specification.new 'asreactor', ASReactor::VERSION do |s|
  s.summary = %q{React to EC2 Auto Scaling activities.}
  s.description = s.summary
  s.license = 'Apache 2.0'
  s.authors = ['Nick Osborn']
  s.homepage = 'https://redzebra.github.io/asreactor'

  s.add_dependency 'aws-sdk', '~> 1.0'
  s.add_dependency 'nokogiri', '~> 1.5.0'
  s.add_dependency 'uuidtools'
  s.require_paths = ['lib']

  s.files = `git ls-files`.split($/) - %w[.gitignore .travis.yml]
  s.executables = s.files.grep(%r{^bin/}) {|f| File.basename(f)}
  s.test_files = s.files.grep(%r{^test\/.*_test.(rb|yml)})
end
