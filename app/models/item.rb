# == Schema Information
#
# Table name: items
#
#  id                                           :bigint           not null, primary key
#  description(Item details)                    :string
#  image(Item Image)                            :string           not null
#  name(Name of the item)                       :string           not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  brand_id(Each item belongs to a brand)       :bigint           not null
#  category_id(Each item belongs to a category) :bigint           not null
#
# Indexes
#
#  index_items_on_brand_id     (brand_id)
#  index_items_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#  fk_rails_...  (category_id => categories.id)
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
