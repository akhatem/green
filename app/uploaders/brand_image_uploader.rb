class BrandImageUploader < CarrierWave::Uploader::Base

    def extension_allowlist
        %w(jpg jpeg gif png)
    end
end
