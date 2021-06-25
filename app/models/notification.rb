# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  create_date :date
#  offer_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_new      :boolean          default(FALSE)
#
class Notification < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :create_date, presence: true

    before_create :set_create_date

    def offerTitle
        Offer.find(offer_id).title
    end


    private

    def set_create_date
        self.write_attribute(:create_date, Date.today)
    end
end
