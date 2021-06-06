class OfferImageUploader < Shrine

    require "image_processing/mini_magick"

    Shrine::Attacher.derivatives :thumbnails do |original|
        magick = ImageProcessing::MiniMagick.source(original)
       
        { large:  magick.resize_to_limit!(600, 600),
          medium: magick.resize_to_limit!(350, 350),
          small:  magick.resize_to_limit!(280, 280) }
    end
end
