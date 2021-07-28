# == Schema Information
#
# Table name: item_sizes
#
#  id         :bigint           not null, primary key
#  item_id    :bigint           not null
#  size_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price      :decimal(10, 2)
#
class ItemSize < ApplicationRecord
    belongs_to :item
    belongs_to :size

    validates :item_id, uniqueness: { scope:  :size_id }

    def sizeName
        Size.find(self.size_id).name
    end

    def size_with_price
        "#{self.sizeName} : #{self.price}"
    end
end
