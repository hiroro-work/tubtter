require_relative 'boot'

# Load env vars before Rails is loaded
require 'aws-sdk-secretsmanager'

# secrets_id = ENV['AWS_SECRET_PREFIX'] || "tubtter-#{ENV['RAILS_ENV']}"
secrets_id = "tubtter-#{ENV['RAILS_ENV']}"
client = Aws::SecretsManager::Client.new
secrets = client.get_secret_value(secret_id: "#{secrets_id}").secret_string

JSON.parse(secrets).each_pair do |key, value|
  ENV["#{key}".underscore.upcase] = value
end

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

puts "username=#{ENV['USERNAME']}"
puts "passowrd=#{ENV['PASSWORD']}"

module Tubtter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
