# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miq_tools_services/version'

Gem::Specification.new do |spec|
  spec.name          = "miq_tools_services"
  spec.version       = MiqToolsServices::VERSION
  spec.authors       = ["Jason Frey"]
  spec.email         = ["jfrey@redhat.com"]
  spec.description   = %q{Shared services for ManageIQ tools and applications}
  spec.summary       = %q{Shared services for ManageIQ tools and applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -- lib/*`.split("\n")
  spec.files        += %w[README.md LICENSE.txt]
  spec.executables   = `git ls-files -- bin/*`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "minigit",       "~> 0.0.4"
  spec.add_dependency "github_api",    "~> 0.14.5"
  spec.add_dependency "active_bugzilla"
  spec.add_dependency "polisher",      "~> 0.10.2"
  spec.add_dependency "awesome_spawn"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "< 3"
end
