require 'spec_helper'

describe Nymphia::DSL::Context do
  context 'Loading DSL file has `load` method' do
    it 'emits warning message' do
      expect {
        Nymphia::DSL::Context.eval('load "examples/company.rb"', 'dummy')
      }.to output(/#load method is obsolated. Use #include_file/).to_stderr_from_any_process
    end
  end
end
