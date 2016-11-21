# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nymphia/version'

Gem::Specification.new do |spec|
  spec.name          = 'nymphia'
  spec.version       = Nymphia::VERSION
  spec.authors       = ['mozamimy (Moza USANE)']
  spec.email         = ['mozamimy@quellencode.org']

  spec.summary       = 'Create your SSH config without any pain.'
  spec.description   = 'Create your SSH config without any pain.'
  spec.homepage      = 'https://github.com/mozamimy/nymphia'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'timecop', '~> 0.8.0'

  spec.add_dependency 'activesupport', '~> 5.0.0.1'
end
