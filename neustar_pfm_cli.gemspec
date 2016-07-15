# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'neustar_pfm_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "neustar_pfm_cli"
  spec.version       = NeustarPfmCli::VERSION
  spec.authors       = ["inokappa"]
  spec.email         = ["inokara at gmail.com"]

  spec.summary       = %q{Command Line Tool for Neustar WebPerformance Management API}
  spec.description   = %q{Command Line Tool for Neustar WebPerformance Management API}
  spec.homepage      = "https://github.com/inokappa"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "thor"
end
