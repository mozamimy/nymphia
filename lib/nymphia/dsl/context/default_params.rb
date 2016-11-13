require 'active_support'
require 'active_support/core_ext'

class Nymphia::DSL::Context::DefaultParams
  include Nymphia::DSL::Context::HostContextMethods

  attr_reader :result

  def initialize(context, &block)
    @context = context
    @result = {
      contents: {},
    }

    instance_eval(&block)
  end
end
