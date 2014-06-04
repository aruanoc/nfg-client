# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nfg-client/version'

Gem::Specification.new do |gem|
  gem.name          = "nfg-client"
  gem.version       = NFGClient::VERSION
  gem.authors       = ["Antonio Ruano Cuesta"]
  gem.email         = ["ruanest@gmail.com"]
  gem.description   = %q{Client for the Network for Good SOAP API.}
  gem.summary       = gem.description
  gem.licenses      = %w(MIT)
  gem.homepage      = "https://github.com/aruanoc/nfg-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'andand', "~> 1.3.3"

  gem.add_development_dependency 'rspec', '~> 2.13.0'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'mocha'
end
