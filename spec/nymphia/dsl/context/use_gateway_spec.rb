require 'spec_helper'

describe Nymphia::DSL::Context::UseGateway do
  subject(:use_gateway) { Nymphia::DSL::Context::UseGateway.new('context', 'name') }

  describe '.new' do
    it 'has @context and @result' do
      expect(use_gateway.instance_variable_get(:@context)).to eq 'context'
      expect(use_gateway.instance_variable_get(:@result)).to eq 'name'
    end
  end
end
