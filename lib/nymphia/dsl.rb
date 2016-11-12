require 'erb'
require 'pathname'

class Nymphia::DSL
  def initialize(dsl_code)
    @dsl_code = dsl_code
  end

  def compile
    @result = Nymphia::DSL::Context.eval(@dsl_code).result
  end

  def render(output: STDOUT)
    ssh_config = ERB.new(File.read(find_template('ssh_config_template.erb')), nil, '-').result(binding)

    output.write(ssh_config)
  end

  private

  def find_template(filename)
    Pathname.new(__FILE__).dirname.join(filename)
  end
end
