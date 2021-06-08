# class CustomerImageUploader < CarrierWave::Uploader::Base
#     include CarrierWave::MiniMagick
  
#     storage :fog
  
#     # def store_dir
#     #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#     # end
  
#     def extension_allowlist
#       %w(jpg jpeg gif png)
#     end
#   end
# end
  
class CustomerBarcodeUploader < Shrine
end