CarrierWave.configure do |config|
    # config.fog_credentials = {
    #   provider:              Rails.application.credentials.digitalocean_spaces[:provider],                        # required
    #   access_key_id: Rails.application.credentials.digitalocean_spaces[:access_key_id],
    #   secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
    #   use_iam_profile:       true,                         # optional, defaults to false
    #   region: 'fra1',
    #   host:                  'fra1.digitaloceanspaces.com',             # optional, defaults to nil
    #   endpoint: Rails.application.credentials.digitalocean_spaces[:endpoint],
    # }
    # # config.fog_directory  = Rails.application.credentials.digitalocean_spaces[:bucket]                                      # required
    # # config.fog_public     = true                                                 # optional, defaults to true
    # # config.fog_attributes = {} # optional, defaults to {}
    # config.asset_host = ActionController::Base.asset_host
    # config.storage = :aws
    # config.aws_bucket = Rails.application.credentials.digitalocean_spaces[:bucket]
    # config.aws_acl    = 'public'
    # config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
    # config.aws_attributes = -> { {
    #   expires: 1.week.from_now.httpdate,
    #   cache_control: 'max-age=604800'
    # } }
    
    # config.aws_credentials = {
    #   access_key_id:     Rails.application.credentials.digitalocean_spaces[:access_key_id],
    #   secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
    #   region: 'fra1',
    #   endpoint: Rails.application.credentials.digitalocean_spaces[:endpoint],
    #   stub_responses:    Rails.env.test? 
    # }

    config.storage = :file
    config.asset_host = ActionController::Base.asset_host
  end