# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
#
# Indexes
#
#  index_categories_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
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
end
  