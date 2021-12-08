# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faithlife/version'

Gem::Specification.new do |s|
  s.name = 'faithlife'
  s.version = Faithlife::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.6.5'

  s.homepage = 'https://github.com/MortarStone/fellowshipone-api-ruby'
  s.rubyforge_project = 'Project on www.github.com'
  s.authors = ['Deb Kallina']
  s.email = ['deb@mortarstone.com']

  s.summary = 'Ruby gem/plugin to interact with the Faithlife API.'
  s.description = 'Ruby gem/plugin to interact with the Faithlife API. Checkout the project on github for more detail.'

  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_dependency 'awrence'
  s.add_dependency 'dotenv'
  s.add_dependency 'json'
  s.add_dependency 'oauth'
  s.add_dependency 'plissken'
  s.add_dependency 'typhoeus'
end
