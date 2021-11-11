# == Schema Information
#
# Table name: branches
#
#  id         :bigint           not null, primary key
#  name       :string
#  link       :string
#  longitude  :decimal(, )
#  latitude   :decimal(, )
#  address    :string
#  city_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Branch < ApplicationRecord

    belongs_to :city

    validates :name, presence: true
    validates :city, presence: true
    validates :longitude, presence: true, if: -> { link.blank? }
    validates :latitude, presence: true, if: -> {link.blank? }
    validates :link, presence: true, if: -> { longitude.blank? || latitude.blank? }
    validates :address, presence: true, if: -> { longitude.blank? || latitude.blank? }    

    def cityName
        City.find(self.city_id).name
    end

    def self.search_by(search_term)
        where(id: search_term.to_i)
        .or(where("name ILIKE ?", "%" + search_term + "%"))
        .or(where(city_id: City.where("name ILIKE ?", "%" + search_term + "%")))
    end
end
