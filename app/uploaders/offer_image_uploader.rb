class OfferImageUploader < CarrierWave::Uploader::Base
    
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

    def filename
        super.chomp(File.extname(super)) + "-" + append_name_code + '.png' if original_filename.present?
    end
end