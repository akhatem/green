# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string
#  image_data  :text             not null
#  brand_id    :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Item < ApplicationRecord
    
    belongs_to :brand
    belongs_to :category
    
    has_many :item_size, dependent: :destroy
    has_many :sizes, through: :item_size, dependent: :destroy
    
    include ItemImageUploader[:image]
    
    validates_presence_of :name,  uniqueness: true, blank: false, null: false, if: -> { !name.present? }
    validates :brand, presence: false, if: -> { !brand.exists? }
    validates :category, presence: false, if: -> { !category.exists? }
    validates :description, presence: false, if: -> { !description.present? }

    def brandName
        Brand.find(self.brand_id).name
    end

    def categoryName
        Category.find(self.category_id).name
    end
end
