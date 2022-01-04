# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'safe_timeout/version'

Gem::Specification.new do |spec|
  spec.name          = "safe_timeout"
  spec.version       = SafeTimeout::VERSION
  spec.authors       = ["David McCullars"]
  spec.email         = ["david.mccullars@gmail.com"]
  spec.summary       = %q{A safer alternative to Ruby's Timeout that uses unix processes instead of threads.}
  spec.description   = %q{A safer alternative to Ruby's Timeout that uses unix processes instead of threads.}
  spec.homepage      = "https://github.com/david-mccullars/safe_timeout"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.8.7'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'github-markup'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov', '~> 0.17.0' # 0.18 not supported by code climate
  spec.add_development_dependency 'yard'
  spec.metadata = {
    'rubygems_mfa_required' => 'true',
  }
end
