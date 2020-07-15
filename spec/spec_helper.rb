ENV['APP_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require "bundler/setup"
require "mockarron"
require 'rack/test'

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include RSpecMixin

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
