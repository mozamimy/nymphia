require 'nymphia'
require 'optparse'
require 'pathname'

module Nymphia
  class CLI
    def self.start(argv)
      new(argv).run
    end

    def initialize(argv)
      @argv = argv.dup
      parser.parse!(@argv)
    end

    def run
      validate_args!

      dsl_code_file = File.open(@file_path)
      absolute_dsl_file_path = File.absolute_path(dsl_code_file.path)
      dsl_code = dsl_code_file.read

      dsl = Nymphia::DSL.new(dsl_code, absolute_dsl_file_path)
      dsl.compile

      if @output_file_path
        File.open(@output_file_path, 'w') do |file|
          dsl.render(file)
        end
      else
        dsl.render(STDOUT)
      end
    end

    private

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = 'nymphia'
        opts.version = Nymphia::VERSION
        opts.on('-f', '--file=FILE', 'Your DSL code file') { |f| @file_path = f }
        opts.on('-o', '--output=FILE', 'Output file (default: stdout)') { |o| @output_file_path = o }
      end
    end

    def validate_args!
      unless @file_path
        raise ArgumentError.new('-f (--file) options is required.')
      end
    end
  end
end
