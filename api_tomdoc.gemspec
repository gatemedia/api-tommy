# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_tomdoc/version'

Gem::Specification.new do |spec|
  spec.name          = 'api_tomdoc'
  spec.version       = ApiTomdoc::VERSION
  spec.authors       = ['David Fernandez']
  spec.email         = ['david.fernandez@gatemedia.ch']
  spec.description   = 'This generator takes one or several rails controllers with comments formatted in TomDoc and spits out a single Markdown file'
  spec.summary       = 'An API documentation generator.'
  spec.homepage      = 'https://github.com/gatemedia'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'activesupport', '~> 4.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry-nav'

  spec.add_runtime_dependency 'tomparse', '~> 0.4'
end
