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
  ActionView::Base.field_error_proc = proc do |html_tag, instance|
    puts "====> html_tag: #{html_tag}"
    puts "====> instance: #{instance}"
    html_tag.gsub("form-control", "form-control is-invalid").html_safe
    # html_tag.insert(html_tag.index('>'), "hint='#{instance.errors.full_messages}'").html_safe
  end
end