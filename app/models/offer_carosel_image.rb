# == Schema Information
#
# Table name: offer_carosel_images
#
#  id         :bigint           not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OfferCaroselImage < ApplicationRecord

    mount_uploader :image, OfferCaroselImageUploader
    
    validates :image, presence: true
end
