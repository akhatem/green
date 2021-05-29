# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Brand < ApplicationRecord
    
    has_many :categories, dependent: :destroy
    # has_many :items, dependent: :destroy

    validates_presence_of :name, blank: false, null: false, if: -> { !name.present? }
    validates :image, presence: false, if: -> { !image.exists? }
    
    mount_uploader :image, BrandImageUploader, mount_on: :image

    
end
