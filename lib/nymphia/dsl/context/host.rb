require 'active_support'
require 'active_support/core_ext'

class Nymphia::DSL::Context::Host
  attr_reader :result

  def initialize(context, name, description, &block)
    @host_name = name
    @context = context.merge(host_name: name)
    @result = {
      metadata: {
        host_name: name,
        description: description,
      },
      contents: {},
    }

    instance_eval(&block)
  end

  private

  def use_identify_file(identity_file_id)
    @result[:contents]['IdentityFile'] = @context[:identity_files][identity_file_id.to_s]
  end

  def method_missing(method, *params)
    @result[:contents][method.to_s.camelize] = params[0]
  end
end
