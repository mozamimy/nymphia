module Nymphia
  class DSL
    class Context
      class DefaultParams
        include HostContextMethods

        attr_reader :result

        def initialize(context, &block)
          @context = context
          @result = {
            contents: {},
          }

          instance_eval(&block)
        end
      end
    end
  end
end
