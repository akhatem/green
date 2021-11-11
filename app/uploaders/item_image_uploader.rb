class ItemImageUploader < CarrierWave::Uploader::Base

    if Rails.env.development?
        storage :file

        def store_dir
            "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end

        def cache_dir
            "tmp/uploads/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end

        def default_url(*args)
            "/assets/defaults/#{model.class.to_s.underscore}"
        end
    end
    
    def extension_allowlist
        %w(jpg jpeg gif png)
    end

    def append_name_code
        charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
        code = Array.new(4) { charset.sample }.uniq.join
        if code.length < 4
            append_name_code
        else
            return code
        end
    end

    def original_filename
        file_ext = File.extname(super)
        super.chomp(File.extname(super)) + "_" + append_name_code + file_ext
    end
end
