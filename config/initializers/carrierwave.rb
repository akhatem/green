include CarrierWave::MiniMagick

CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
        provider: Rails.application.credentials.digitalocean_spaces[:provider],
        aws_access_key_id: Rails.application.credentials.digitalocean_spaces[:access_key_id],
        aws_secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
        region: Rails.application.credentials.digitalocean_spaces[:region],
        bucket: Rails.application.credentials.digitalocean_spaces[:bucket],
        endpoint: Rails.application.credentials.digitalocean_spaces[:endpoint]
    }
    config.fog_public = true
    # config.asset_host = "http://green.mmgunited.com"
    config.fog_directory  = Rails.application.credentials.digitalocean_spaces[:bucket]
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end