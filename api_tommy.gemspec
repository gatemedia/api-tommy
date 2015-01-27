# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "api_tommy/version"

Gem::Specification.new do |s|
  s.name          = "api_tommy"
  s.version       = ApiTommy::VERSION
  s.authors       = ["David Fernandez"]
  s.email         = ["david.fernandez@gatemedia.ch"]
  s.description   = "This generator takes one or several classes with comments formatted in TomDoc and spits out a single Markdown file"
  s.summary       = "An API documentation generator based on RDoc and TomDoc"
  s.homepage      = "https://github.com/gatemedia/api-tommy"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rdoc", "~> 4.2"
  s.add_runtime_dependency "tomparse", "~> 0.4"
  s.add_runtime_dependency "grit", "~> 2.5"
  s.add_runtime_dependency "activesupport", "~> 4.2"

  s.add_development_dependency "mocha", "~> 0.14"
  s.add_development_dependency "pry", "~> 0.10"
  s.add_development_dependency "minitest-reporters", "~> 1.0"
  s.add_development_dependency "simplecov", "~> 0.8"
  s.add_development_dependency "rake", "~> 10.4"
end
