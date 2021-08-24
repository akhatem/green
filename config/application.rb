require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Green
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = "Africa/Cairo"
    config.active_record.default_timezone = :local

    
    config.load_defaults 6.1
    config.autoload_paths += %W[#{config.root}/lib]
    
    config.active_job.queue_adapter = :sidekiq

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, expose: ["Authorization"], methods: [:get, :patch, :put, :delete, :post, :options, :show]
      end
    end

  end
end