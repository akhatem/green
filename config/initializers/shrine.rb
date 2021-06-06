require "shrine"
require 'shrine/storage/file_system'
require 'shrine/storage/memory'
require 'shrine/storage/s3'

if Rails.env.development? or Rails.env.test?
    Shrine.storages = {
        cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
        store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permenant
    }
else
    s3_options = {
        access_key_id: Rails.application.credentials.digitalocean_spaces[:access_key_id],
        secret_access_key: Rails.application.credentials.digitalocean_spaces[:secret_access_key],
        bucket: Rails.application.credentials.digitalocean[:bucket],
        endpoint: 'https://fra1.digitaloceanspaces.com',
        region: 'fra1'
    }
    
    Shrine.storages = {
        cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: {acl: 'public-read'}, **s3_options), # temporary
        store: Shrine::Storage::S3.new(prefix: 'sotre', upload_options: {acl: 'public-read'}, **s3_options), # permenant
    }
end

Shrine.plugin :derivatives
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :validation
Shrine.plugin :validation_helpers