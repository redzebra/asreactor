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

require 'asreactor'
require 'getoptlong'

module ASReactor
  class CommandLine
    # @param program [String]
    def initialize(program)
      ASReactor.config_file = "#{program}.yml"
      begin
        parse_options(program)
      rescue GetoptLong::InvalidOption => e
        Kernel.abort("Try '#{program} --help' for more information.")
      end
      unless ARGV.empty?
        Kernel.abort("Try '#{program} --help' for more information.")
      end

      begin
        config = ASReactor.config
      rescue Errno::ENOENT => e
        Kernel.abort("#{program}: #{e.message}")
      end
    end

    def run
      daemonize unless ASReactor.debug
      #ASReactor::Util::Log.close(:console)

      @listener = ASReactor::Listener.new
      @listener.run
    end

    private

    # @api private
    def daemonize
      if RUBY_VERSION < "1.9"
        Kernel.exit if fork
        Process.setsid
        Kernel.exit if fork
        Dir.chdir('/')
        STDIN.reopen('/dev/null')
        STDOUT.reopen('/dev/null', 'a')
        STDERR.reopen('/dev/null', 'a')
      else
        Process.daemon
      end
    end

    # @api private
    def parse_options(program)
      opts = GetoptLong.new(
        ['--config-file', '-c', GetoptLong::REQUIRED_ARGUMENT],
        ['--debug',       '-D', GetoptLong::NO_ARGUMENT],
        ['--help',        '-h', GetoptLong::NO_ARGUMENT],
        ['--verbose',     '-v', GetoptLong::NO_ARGUMENT]
      )

      opts.each do |opt, arg|
        case opt
        when '--config-file'
          ASReactor.config_file = arg
        when '--debug'
          ASReactor.debug = true
        when '--help'
          $stderr.puts <<END
Auto Scaling Reactor version #{ASReactor::VERSION}

Usage: #{program} [OPTIONS]

    --config-file=FILE  ...

    -v, --verbose       ...
    -D, --debug         ...
    -h, --help          ...

END
          Kernel.exit(1)
        when '--verbose'
          ASReactor.verbose = true
        end
      end
    end
  end
end
