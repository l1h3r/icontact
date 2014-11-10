require 'webmock/rspec'
require 'faker'
require 'icontact'
require 'yaml'
require 'vcr'

def options
  path = File.join(File.dirname(__FILE__), '../config/test.yml')
  @options ||= YAML::load_file(File.expand_path(path))
end

def client
  @client ||= IContact::Api.new(options['username'], options['password'], options['app_id'])
end

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  # config.debug_logger = File.open('log/vcr.log', 'w')
  config.hook_into :webmock

  config.filter_sensitive_data('<-APP-ID->') { options['app_id'] }
  config.filter_sensitive_data('<-API-USERNAME->') { options['username'] }
  config.filter_sensitive_data('<-API-PASSWORD->') { options['password'] }
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
