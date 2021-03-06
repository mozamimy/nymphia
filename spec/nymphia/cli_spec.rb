require 'spec_helper'

describe Nymphia::DSL do
  describe '#run' do
    context 'when -f is given' do
      subject(:cli) { Nymphia::CLI.new(['-f', 'examples/base.rb']) }

      it 'contains nymphia header in stdout' do
        expect { subject.run }.to output(/# This config is generated by Nymphia/).to_stdout_from_any_process
      end
    end

    context 'when -o is given' do
      let(:argv) { ['-f', 'examples/base.rb', '-o', 'tmp/config'] }
      subject(:cli) { Nymphia::CLI.new(argv) }

      before { subject.run }
      after { File.delete('tmp/config') }

      it 'puts to result to `config` file' do
        expect(File.read('tmp/config')).to include '# This config is generated by Nymphia'
      end
    end

    context 'without any options' do
      subject(:cli) { Nymphia::CLI.new([]) }

      it 'contains nymphia header in stdout' do
        expect { subject.run }.to raise_error(ArgumentError)
      end
    end
  end
end
