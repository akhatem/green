# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class City < ApplicationRecord
    has_many :branches, dependent: :destroy
    validates_presence_of :name, null: false, blank: false
end
