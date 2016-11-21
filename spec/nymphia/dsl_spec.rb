require 'spec_helper'
require 'timecop'

describe Nymphia::DSL do
  subject(:dsl) { Nymphia::DSL.new('', '') }

  describe '#render' do
    before { Timecop.freeze(2016, 11, 21, 23, 35, 47) }
    after { Timecop.return }

    it 'contains date and time in ISO 8601 format' do
      output = StringIO.new

      dsl.compile
      dsl.render(output)
      output.rewind

      expect(output.read).to match /2016-11-21T23:35:47\+\d\d:\d\d/
    end
  end
end
