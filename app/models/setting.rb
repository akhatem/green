# == Schema Information
#
# Table name: settings
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  key         :string
#
class Setting < ApplicationRecord

    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :description, presence: true
    validates :key, uniqueness: { case_sensitive: false }


    after_create :generate_key
    
    private 
    
    def generate_key
        self.update(key: self.name.gsub(' ', '').underscore)
    end
end
