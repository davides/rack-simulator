# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/simulator/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-simulator"
  spec.version       = Rack::Simulator::VERSION
  spec.authors       = ["davides"]
  spec.email         = ["desiobu@gmail.com"]
  spec.summary       = %q{A general API simulator.}
  spec.description   = %q{A general API simulator.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "rack-streaming-proxy"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
