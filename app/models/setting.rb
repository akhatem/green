# == Schema Information
#
# Table name: settings
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Setting < ApplicationRecord

    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :descirption, presence: true
end
