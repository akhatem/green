# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  brand_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  
    belongs_to :brand
    has_many :items, dependent: :destroy

    validates :name, uniqueness: { scope: :brand, case_sensitive: false }
    validates :name, presence: false, if: -> { !name.present? }
    validates :brand, presence: false, if: -> { !brand.exists?}
  
    def brandName
      Brand.find(self.brand_id).name
    end

    def self.search_by(search_term)
      where("id = ?", search_term.to_i)
      .or(where("name ILIKE ?", "%" + search_term + "%"))
      .or(where(brand_id: Brand.where("name ILIKE ?", "%" + search_term + "%")))
    end
end
  
