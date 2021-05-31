# == Schema Information
#
# Table name: item_sizes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  size_id    :bigint           not null
#
# Indexes
#
#  index_item_sizes_on_item_id  (item_id)
#  index_item_sizes_on_size_id  (size_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (size_id => sizes.id)
#
class ItemSize < ApplicationRecord
    belongs_to :item
    belongs_to :size

    validates :item_id, uniqueness: { scope:  :size_id }
end