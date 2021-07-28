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
class Item < ApplicationRecord
    
    belongs_to :brand
    belongs_to :category
    
    has_many :item_sizes, dependent: :destroy
    has_many :sizes, through: :item_sizes, dependent: :destroy
    accepts_nested_attributes_for :item_sizes, allow_destroy: true, reject_if: :all_blank
    
    mount_uploader :image, ItemImageUploader
    
    validates_presence_of :name, uniqueness: true, blank: false, null: false, if: -> { !name.present? }
    validates :brand, presence: false, if: -> { !brand.exists? }
    validates :category, presence: false, if: -> { !category.exists? }
    validates :description, presence: false, if: -> { !description.present? }

    def brandName
        Brand.find(self.brand_id).name
    end

    def categoryName
        Category.find(self.category_id).name
    end
    
    def self.search_by(search_term)
        where("id = ?", search_term.to_i)
        .or(where("LOWER(name) LIKE ?", "%" + search_term.downcase + "%"))
        .or(where("brand_id = ?", Brand.find_by(name: search_term)))
        .or(where("category_id = ?", Category.find_by(name: search_term)))
    end
end
