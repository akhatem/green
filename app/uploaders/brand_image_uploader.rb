class BrandImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
  
    # storage :fog
    storage :aws
  
    # def store_dir
    #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.name.to_s.underscore}"
    # end
  
    def extension_whitelist
      %w(jpg jpeg gif png)
    end
  end
  