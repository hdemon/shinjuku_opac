# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shinjuku_opac/version'
require 'pry'
require 'pp'

Gem::Specification.new do |spec|
  spec.name          = "shinjuku_opac"
  spec.version       = ShinjukuOPAC::VERSION
  spec.authors       = ["Masami Yonehara"]
  spec.email         = ["zeitdiebe@gmail.com"]
  spec.summary       = %q{the manipulater of the shinjyuku opac}
  spec.description   = %q{the manipulater of the shinjyuku opac}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara"
  spec.add_dependency "capybara-webkit"
  spec.add_dependency "poltergeist"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
