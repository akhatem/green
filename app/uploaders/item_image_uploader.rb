# class ItemImageUploader < CarrierWave::Uploader::Base
#     include CarrierWave::MiniMagick
  
#     # storage :fog
#     # storage :aws
#     storage :file
  
#     # def store_dir
#     #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#     # end
  
#     def extension_allowlist
#       %w(jpg jpeg gif png)
#     end
#   end
# end

class ItemImageUploader < Shrine
end