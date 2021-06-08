# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  image_data :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Brand < ApplicationRecord
    include BrandImageUploader[:image]
    
    has_many :categories, dependent: :destroy
    has_many :items, dependent: :destroy

    validates_presence_of :name, blank: false, null: false, if: -> { !name.present? }
    validates :image, presence: false, if: -> { !image.exists? }

    
end
