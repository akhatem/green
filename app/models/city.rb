class City < ApplicationRecord
    has_many :branches, dependent: :destroy
    validates_presence_of :name, null: false, blank: false
end
