class Notification < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :create_date, presence: true
end
