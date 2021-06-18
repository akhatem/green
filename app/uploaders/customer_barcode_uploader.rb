class CustomerBarcodeUploader < CarrierWave::Uploader::Base
    
        storage :file

        def store_dir
            "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end

        def cache_dir
        "tmp/uploads/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
    
    def extension_allowlist
        %w(jpg jpeg gif png)
    end
end