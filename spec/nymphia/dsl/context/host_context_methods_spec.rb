require 'spec_helper'

describe Nymphia::DSL::Context::HostContextMethods do
  class Anonymous
    include Nymphia::DSL::Context::HostContextMethods

    def initialize
      @result = {
        contents: {},
      }

      @context = {
        identity_files: {
          'private' => '~/.ssh/private.pem',
          'company' => '~/.ssh/company.pem',
        },
      }
    end
  end

  subject(:object) { Anonymous.new }

  describe '#use_identify_file' do
    it 'contains file path for key file' do
      result = {
        contents: {
          'IdentityFile' => ['~/.ssh/company.pem'],
        },
      }

      object.send(:use_identify_file, :company)
      expect(object.instance_variable_get(:@result)).to eq result
    end
  end
end
