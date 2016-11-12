require 'nymphia'
require 'optparse'

class Nymphia::CLI
  def self.start(argv)
    new(argv).run
  end

  def initialize(argv)
    @argv = argv.dup
    parser.order!(@argv)
  end

  def run
    dsl_code = STDIN.read

    dsl = Nymphia::DSL.new(dsl_code)
    dsl.compile
    dsl.render
  end

  private

  def parser
    @parser ||= OptionParser.new do |opts|
      opts.banner = 'nymphia'
      opts.version = Nymphia::VERSION
    end
  end
end
