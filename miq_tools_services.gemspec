# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miq_tools_services/version'

Gem::Specification.new do |spec|

  # Dynamically create the authors information {name => e-mail}
  authors_hash = Hash[`git log --no-merges --reverse --format='%an,%ae'`.split("\n").uniq.collect {|i| i.split(",")}]

  spec.name          = "miq_tools_services"
  spec.version       = MiqToolsServices::VERSION
  spec.authors       = authors_hash.keys
  spec.email         = authors_hash.values
  spec.description   = %q{Shared services for ManageIQ tools and applications}
  spec.summary       = %q{Shared services for ManageIQ tools and applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -- lib/*`.split("\n")
  spec.files        += %w[README.md LICENSE.txt]
  spec.executables   = `git ls-files -- bin/*`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_dependency "active_bugzilla"
  spec.add_dependency "activesupport"
  spec.add_dependency "github_api",    "~> 0.11.1"
  spec.add_dependency "minigit",       "~> 0.0.4"
  spec.add_dependency "polisher",      "~> 0.10.2"
  spec.add_dependency "sidekiq",       "~> 3.5.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",   "< 3"
end
