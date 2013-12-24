# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-wordpress-oauth2-plugin/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'omniauth-oauth2'

  spec.name          = "omniauth-wordpress-oauth2-plugin"
  spec.version       = Omniauth::Wordpress::Oauth2::Plugin::VERSION
  spec.authors       = ["Joel Wickard"]
  spec.email         = ["jwickard@gmail.com"]
  spec.description   = %q{A Wordpress Oauth2 Provider Plugin Strategy for Omniauth}
  spec.summary       = %q{A Wordpress Oauth2 Provider Plugin Strategy for Omniaut}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
