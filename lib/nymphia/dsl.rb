require 'erb'
require 'pathname'

class Nymphia::DSL
  def initialize(dsl_code, path)
    @dsl_code = dsl_code
    @path = path
  end

  def compile
    @result = Nymphia::DSL::Context.eval(@dsl_code, @path).result
  end

  def render(output)
    ssh_config = ERB.new(File.read(find_template('ssh_config_template.erb')), nil, '-').result(binding)
    output.write(ssh_config)
  end

  private

  def find_template(filename)
    Pathname.new(__FILE__).dirname.join(filename)
  end
end
