module Nymphia
  class DSL
    class Context
      module HostContextMethods
        private

        def use_identify_file(*identity_file_ids)
          @result[:contents]['IdentityFile'] = []

          identity_file_ids.each do |identity_file_id|
            @result[:contents]['IdentityFile'] << @context[:identity_files][identity_file_id.to_s]
          end
        end

        def method_missing(method, *params)
          key = camelize(method.to_s)

          if @default_params && @default_params[key]
            @result[:contents][key] = Array(params[0])
            @default_params.delete(key)
          end

          if @result[:contents][key]
            @result[:contents][key] << params[0]
          else
            @result[:contents][key] = Array(params[0])
          end
        end

        private

        def camelize(str)
          str.split('_').collect(&:capitalize).join
        end
      end
    end
  end
end
