CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              Rails.application.credentials.digitalocean_spaces[:provider],                        # required
      access_key_id: Rails.application.credentials.digitalocean_spaces[:access_key_id],
      secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
      use_iam_profile:       true,                         # optional, defaults to false
      region: 'fra1'
      host:                  'fra1.digitaloceanspaces.com',             # optional, defaults to nil
      endpoint: Rails.application.credentials.digitalocean_spaces[:endpoint],
    }
    config.fog_directory  = Rails.application.credentials.digitalocean[:bucket],                                      # required
    config.fog_public     = true                                                 # optional, defaults to true
    config.fog_attributes = {} # optional, defaults to {}
    # For an application which utilizes multiple servers but does not need caches persisted across requests,
    # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
    # config.cache_storage = :file
  end