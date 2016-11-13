class Nymphia::DSL::Context::Group
  include Nymphia::DSL::RecursiveMethods

  attr_reader :result

  def initialize(context, name, &block)
    @group_name = name
    @context = context
    @result = {
      hosts: [],
    }

    instance_eval(&block)
  end
end
