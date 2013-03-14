# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crosscounter/version'

Gem::Specification.new do |gem|
  gem.name          = 'crosscounter'
  gem.version       = Crosscounter::VERSION
  gem.authors       = ['Parker Selbert']
  gem.email         = ['parker@sorentwo.com']
  gem.description   = %(Functionally create cross tabulations)
  gem.summary       = %(
    Crosscounter allows you to create a simple pipeline for defining cross
    tabulated output)
  gem.homepage      = 'https://github.com/sorentwo/crosscounter'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake',  '~> 10.0.3'
  gem.add_development_dependency 'rspec', '~> 2.12.0'
end
