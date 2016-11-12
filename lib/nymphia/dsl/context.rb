class Nymphia::DSL::Context
  attr_reader :result

  def self.eval(dsl_code)
    new do
      eval(dsl_code)
    end
  end

  def initialize(&block)
    @context = {
      identity_files: {},
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

  def host(name, description, &block)
    name = name.to_s
    description = description.to_s

    new_host = Nymphia::DSL::Context::Host.new(@context, name, description, &block).result
    @result[:hosts] << new_host
  end
end
