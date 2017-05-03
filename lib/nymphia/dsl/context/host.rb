class Nymphia::DSL::Context::Host
  include Nymphia::DSL::Context::HostContextMethods

  attr_reader :result

  def initialize(context, name, description, default_params, gateway_usage, &block)
    @host_name = name
    @context = context.merge(host_name: name)
    @result = {
      metadata: {
        host_name: name,
        description: description,
      },
    }

    if default_params.nil?
      @result[:contents] = {}
    else
      @default_params = default_params.dup
      @result[:contents] = @default_params
    end

    unless gateway_usage.nil?
      proxy_command = "ssh #{@context[:gateways][gateway_usage][:metadata][:host_name]} -q -W %h:%p"

      if @result[:contents]['ProxyCommand']
        @result[:contents]['ProxyCommand'] << proxy_command
      else
        @result[:contents]['ProxyCommand'] = Array(proxy_command)
      end
    end

    instance_eval(&block) if block
  end
end
