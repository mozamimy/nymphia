module Nymphia
  class DSL
    class Context
      class Gateway < Host
        def initialize(context, name, description, default_params, gateway_usage, &block)
          super(context, name, description, default_params, gateway_usage, &block)
          @context[:gateways][name] = @result
        end
      end
    end
  end
end
