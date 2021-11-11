# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string
#  image       :string
#  brand_id    :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

include ActionView::Helpers::NumberHelper
class Item < ApplicationRecord
    
    belongs_to :brand
    belongs_to :category
    
    has_many :item_sizes, dependent: :destroy
    has_many :sizes, through: :item_sizes
    accepts_nested_attributes_for :item_sizes, allow_destroy: true, reject_if: :all_blank
    
    mount_uploader :image, ItemImageUploader
    
    validates_presence_of :name, uniqueness: true, blank: false, null: false, if: -> { !name.present? }
    validates :image, presence: true
    validates :brand, presence: true
    validates :category, presence: true
    validates :description, presence: true

    def brandName
        Brand.find(self.brand_id).name
    end

    def categoryName
        Category.find(self.category_id).name
    end
    
    def self.search_by(search_term)
        where("id = ?", search_term.to_i)
        .or(where("name ILIKE ?", "%" + search_term + "%"))
        .or(where(brand_id: Brand.where("name ILIKE ?", "%" + search_term + "%")))
        .or(where(category_id: Category.where("name ILIKE ?", "%" + search_term + "%")))
    end
end
