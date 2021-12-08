# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faithlife/version'

Gem::Specification.new do |spec|
  spec.name = 'faithlife'
  spec.version = Faithlife::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6.5'

  spec.homepage = 'https://github.com/MortarStone/fellowshipone-api-ruby'
  spec.rubyforge_project = 'Project on www.github.com'
  spec.authors = ['Deb Kallina']
  spec.email = ['deb@mortarstone.com']

  spec.summary = 'Ruby gem/plugin to interact with the Faithlife API.'
  spec.description = 'Ruby gem/plugin to interact with the Faithlife API. Checkout the project on github for more detail.'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_dependency 'awrence'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'json'
  spec.add_dependency 'oauth'
  spec.add_dependency 'plissken'
  spec.add_dependency 'typhoeus'
end
