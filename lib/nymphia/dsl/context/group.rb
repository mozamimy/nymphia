module Nymphia
  class DSL
    class Context
      class Group
        include RecursiveMethods

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
    end
  end
end
