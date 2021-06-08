# == Schema Information
#
# Table name: branches
#
#  id         :bigint           not null, primary key
#  name       :string
#  link       :string
#  long       :decimal(, )
#  lat        :decimal(, )
#  address    :string
#  city_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Branch < ApplicationRecord

    belongs_to :city

    validates :city, presence: true

    validates :long, presence: true, if: -> { link.blank? }
    validates :lat, presence: true, if: -> {link.blank? }
    validates :link, presence: true, if: -> { long.blank? || lat.blank? }
    validates :address, presence: true, if: -> { long.blank? || lat.blank? }

    def cityName
        City.find(self.city_id).name
    end
end
