module Nymphia
  class DSL
    class Context
      class Proxy < Host
        def initialize(context, name, description, default_params, gateway_usage, &block)
          super(context, name, description, default_params, gateway_usage, &block)
        end

        def local_forward(name, params)
          name = name.to_s

          local_forward_arg = ''
          params.each do |host, port|
            local_forward_arg << "#{host}:#{port} "
          end
          local_forward_arg.strip!

          if @result[:contents]['LocalForward']
            @result[:contents]['LocalForward'] << local_forward_arg
          else
            @result[:contents]['LocalForward'] = Array(local_forward_arg)
          end
        end
      end
    end
  end
end
