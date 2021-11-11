include CarrierWave::MiniMagick

# if Rails.env.development?
#     CarrierWave.configure do |config|
#         config.storage = :file  
#         config.root = Rails.root
#     end
# end

if Rails.env.production?
    CarrierWave.configure do |config|
        config.storage = :fog
        config.fog_credentials = {
            provider: Rails.application.credentials.digitalocean_spaces[:provider],
            aws_access_key_id: Rails.application.credentials.digitalocean_spaces[:access_key_id],
            aws_secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
            region: Rails.application.credentials.digitalocean_spaces[:region],
            endpoint: Rails.application.credentials.digitalocean_spaces[:endpoint]
        }
        config.fog_public = true
        config.fog_directory  = Rails.application.credentials.digitalocean_spaces[:bucket]
        config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
    end
end