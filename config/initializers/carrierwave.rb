include CarrierWave::MiniMagick


if Rails.env.production?

    CarrierWave.configure do |config|
        config.storage = :fog
        config.fog_credentials = {
            provider: Rails.application.credentials.digitalocean_spaces[:provider],
            access_key_id: Rails.application.credentials.digitalocean_spaces[:access_key_id],
            secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
            use_iam_profile: true, 
            region: Rails.application.credentials.digitalocean_spaces[:region],
            # bucket: Rails.application.credentials.digitalocean_spaces[:bucket],
            endpoint: Rails.application.credentials.digitalocean_spaces[:endpoint]
        }
        config.fog_directory  = Rails.application.credentials.digitalocean_spaces[:bucket]
        config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    end
end