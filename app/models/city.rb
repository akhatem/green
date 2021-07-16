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

    def self.search_by(search_term)
        where("id = ?", search_term.to_i)
        .or(where("name ILIKE ?", "%" + search_term + "%"))
        .or(where(created_at: "%" + search_term + "%"))
      end
end
