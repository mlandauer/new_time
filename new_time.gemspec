# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'new_time/version'

Gem::Specification.new do |spec|
  spec.name          = "new_time"
  spec.version       = NewTime::VERSION
  spec.authors       = ["Matthew Landauer"]
  spec.email         = ["matthew@oaf.org.au"]
  spec.summary       = "A new kind of time that anchors you to the movement of the sun"
  spec.description   = "A new kind of time"
  spec.homepage      = 'https://github.com/mlandauer/new_time'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 0'

  spec.add_dependency "RubySunrise", '~> 0'
end
