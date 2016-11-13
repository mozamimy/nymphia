class Nymphia::DSL::Context::UseGateway
  attr_reader :result

  def initialize(context, name)
    @context = context
    @result = name
  end
end
