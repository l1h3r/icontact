require 'icontact'
require 'yaml'

# Set your username, password, and app id in spec/config.yml
# EXAMPLE:
#   username: 'user@example.com'
#   password: 'your-api-password'
#   app_id:   'your-app-id'


def options
  path = File.join(File.dirname(__FILE__), 'config.yml')
  @options ||= YAML::load_file(path)
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
