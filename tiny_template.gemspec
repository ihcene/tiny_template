# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tiny_template/version'

Gem::Specification.new do |spec|
  spec.name          = "tiny_template"
  spec.version       = TinyTemplate::VERSION
  spec.authors       = ["Ihcène Medjber (ihcene)"]
  spec.email         = ["i@aritylabs.com"]
  spec.summary       = %q{Magical and secure string interpolation.}
  spec.description   = %q{A very simple template engine that allows you to interpolate method chains without passing it any data}
  spec.homepage      = "http://github.com/ihcene/tiny_template"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "debug_inspector", '~> 0.0', '>= 0.0.2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
end
