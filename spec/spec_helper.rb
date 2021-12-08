# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

SimpleCov.at_exit do
  SimpleCov.minimum_coverage 98
end

require 'dotenv/load'
require 'factory_bot'
require 'bundler/setup'
require 'faithlife'
require 'vcr'
require 'pry'

Dir[File.join(File.dirname(__FILE__), '/support/**/*.rb')].sort.each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock, :typhoeus
  config.default_cassette_options = { record: :once }
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
