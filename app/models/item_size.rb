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
    validates :price, presence: true
    validate :count_of_sizes

    def price_with_precision
        number_with_precision(self.price, precision: 2)
    end

    def sizeName
        Size.find(self.size_id).name
    end

    def size_with_price
        "#{self.sizeName} : #{self.price}"
    end

    private

    def count_of_sizes
        if ItemSize.where(item_id: self.item_id).count.eql?(1)
            self.errors.add("", "Item Must have at least 1 size and price!")
        end
    end
end
