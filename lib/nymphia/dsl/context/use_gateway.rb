module Nymphia
  class DSL
    class Context
      class UseGateway
        attr_reader :result

        def initialize(context, name)
          @context = context
          @result = name
        end
      end
    end
  end
end
