require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yrsa
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_controller.permit_all_parameters = true
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # config.active_record.raise_in_transactional_callbacks = true

      config.paperclip_defaults = {
          :storage => :s3, 
          :s3_host_name => 's3-us-east-2.amazonaws.com',
          :s3_region => ENV['AWS_REGION'],
          :s3_credentials => {
              :bucket => ENV['AWS_BUCKET'],
              :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
              :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
          }
      }

    config.time_zone = 'Pacific Time (US & Canada)'
    config.active_record.default_timezone = :local
  end
end
