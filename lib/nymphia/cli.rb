require 'nymphia'
require 'optparse'
require 'pathname'

class Nymphia::CLI
  def self.start(argv)
    new(argv).run
  end

  def initialize(argv)
    @argv = argv.dup
    parser.order!(@argv)
  end

  def run
    dsl_code_file = File.open(@file_path)
    absolute_dsl_file_path = File.absolute_path(dsl_code_file.path)
    dsl_code = dsl_code_file.read

    dsl = Nymphia::DSL.new(dsl_code, absolute_dsl_file_path)
    dsl.compile
    dsl.render
  end

  private

  def parser
    @parser ||= OptionParser.new do |opts|
      opts.banner = 'nymphia'
      opts.version = Nymphia::VERSION
      opts.on('-f', '--file=FILE', 'Your DSL code file') { |f| @file_path = f }
    end
  end
end
