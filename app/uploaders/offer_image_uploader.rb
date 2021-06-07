# class OfferImageUploader < Shrine

#     require "image_processing/mini_magick"

#     Shrine::Attacher.derivatives :thumbnails do |original|
#         magick = ImageProcessing::MiniMagick.source(original)
       
#         { large:  magick.resize_to_limit!(600, 600),
#           medium: magick.resize_to_limit!(350, 350),
#           small:  magick.resize_to_limit!(280, 280) }
#     end
# end


class OfferImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
  
    # storage :fog
    storage :aws
  
    # def store_dir
    #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    # end
  
    def extension_allowlist
      %w(jpg jpeg gif png)
    end
  end
  