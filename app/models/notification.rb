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
#  is_new      :boolean          default(TRUE)
#
class Notification < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :create_date, presence: true

    before_create :set_create_date
    before_save :update_customer_has_new_notification

    def offerTitle
        Offer.find(offer_id).title
    end

    def self.search_by(search_term)
        where("id = ? OR LOWER(name) LIKE ? OR create_date LIKE ? OR LOWER(is_new) LIKE ? ",
            search_term.to_i, "%" + search_term + "%", "%" + search_term + "%", "%" + search_term.downcase + "%")
    end


    private

    def set_create_date
        self.write_attribute(:create_date, Date.today)
    end

    def update_customer_has_new_notification
        Customer.all.each do |customer|
            customer.update_column(:has_new_notification, true)
            puts "================= > update_customer_has_new_notification : #{customer.update_column(:has_new_notification, true)}"
            puts "================= > has new notification for all customers updated successfully."
        end
    end
end
