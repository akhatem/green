# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  name        :string
#  key         :string
#  description :text
#  is_super    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Role < ApplicationRecord

    has_many :users, dependent: :restrict_with_error

    validates_presence_of :name
    validates_uniqueness_of :name, case_sensitive: false
    validates_uniqueness_of :key, case_sensitive: false

    after_create :generate_key

    def self.get_super
        self.where(is_super: true).first
    end

    def is_super?
        self.is_super
    end

    def self.search_by(search_term)
        where("id = ?", search_term.to_i)
        .or(where("LOWER(name) LIKE ?", "%" + search_term.downcase + "%"))
    end
    
    private

    def generate_key
        self.update(key: self.name.gsub(' ', '_').underscore)
    end
end
