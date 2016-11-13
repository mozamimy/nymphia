class Nymphia::DSL::Context::Gateway < Nymphia::DSL::Context::Host
  def initialize(context, name, description, default_params, gateway_usage, &block)
    super(context, name, description, default_params, gateway_usage, &block)
    @context[:gateways][name] = @result
  end
end
