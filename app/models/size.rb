# == Schema Information
#
# Table name: sizes
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Size < ApplicationRecord
    
    has_many :item_sizes
    has_many :items, through: :item_sizes
  
end
