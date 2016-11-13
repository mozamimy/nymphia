module Nymphia::DSL::RecursiveMethods
  private

  def default_params(&block)
    new_default_params = Nymphia::DSL::Context::DefaultParams.new(@context, &block).result[:contents]
    @context[:default_params][@group_name] = new_default_params
  end

  def use_gateway(name)
    name = name.to_s

    new_gateway_usage = Nymphia::DSL::Context::UseGateway.new(@context, name).result
    @context[:gateway_usage][@group_name] = new_gateway_usage
  end

  def host(name, description=nil, &block)
    process_dsl_with(Nymphia::DSL::Context::Host, name, description, &block)
  end

  def gateway(name, description=nil, &block)
    process_dsl_with(Nymphia::DSL::Context::Gateway, name, description, &block)
  end

  def proxy(name, description=nil, &block)
    process_dsl_with(Nymphia::DSL::Context::Proxy, name, description, &block)
  end

  def process_dsl_with(dsl_class, name, description, &block)
    name = name.to_s
    description = description.to_s if description
    default_params = @context[:default_params][@group_name]
    gateway_usage = @context[:gateway_usage][@group_name]

    new_host = dsl_class.new(
      @context,
      name,
      description,
      default_params,
      gateway_usage,
      &block
    ).result

    @result[:hosts] << new_host
  end

  def group(name, &block)
    name = name.to_s

    new_hosts = Nymphia::DSL::Context::Group.new(@context, name, &block).result[:hosts]
    @result[:hosts].concat(new_hosts)
  end
end
