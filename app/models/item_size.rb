# == Schema Information
#
# Table name: item_sizes
#
#  id         :bigint           not null, primary key
#  item_id    :bigint           not null
#  size_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ItemSize < ApplicationRecord
    belongs_to :item
    belongs_to :size

    validates :item_id, uniqueness: { scope:  :size_id }
end
