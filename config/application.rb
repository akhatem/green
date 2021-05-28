require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Greensapi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
  
  
    config.active_job.queue_adapter = :sidekiq


    config.autoload_paths += %W[#{config.root}/lib]

  end
end