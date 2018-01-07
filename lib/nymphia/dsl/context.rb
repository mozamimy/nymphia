require 'pathname'

class Nymphia::DSL::Context
  include Nymphia::DSL::RecursiveMethods

  attr_reader :result

  def self.eval(dsl_code, path)
    new(path) do
      eval(dsl_code, binding, path)
    end
  end

  def initialize(path, &block)
    @path = path

    @context = {
      identity_files: {},
      gateways: {},
      default_params: {},
      gateway_usage: {},
    }

    @result = {
      hosts: [],
    }

    instance_eval(&block)
  end

  private

  def identity_file(name, path)
    name = name.to_s
    path = path.to_s
    @context[:identity_files][name] = path
  end

  def load(load_file_path)
    warn "#{caller[0]}: #load method is obsolated. Use #include_file"
    include_file(load_file_path)
  end

  def include_file(load_file_path)
    absolute_load_file_path = Pathname.new(@path).dirname.join(load_file_path)
    dsl_code = File.read(absolute_load_file_path)

    instance_eval(dsl_code, absolute_load_file_path.to_s)
  end
end
