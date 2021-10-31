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
#  image       :string
#
class Notification < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :create_date, presence: true

    mount_uploader :image, NotificationImageUploader

    before_create :set_create_date
    before_save :update_customer_has_new_notification
    after_create :set_image, :create_push_notification
    before_destroy :delete_offer

    def offerTitle
        Offer.find(offer_id).title
    end

    def update_date
        self.updated_at
    end

    def self.search_by(search_term)
        where("id = ? OR LOWER(name) LIKE ? OR create_date LIKE ? OR LOWER(is_new) LIKE ? ",
            search_term.to_i, "%" + search_term + "%", "%" + search_term + "%", "%" + search_term.downcase + "%")
    end


    private

    def set_create_date
        self.write_attribute(:create_date, Date.today)
    end

    def set_image
        self.update(image: File.open(File.join(Rails.root, 'app/assets/images/main_logo.png'))) if self.offer_id.nil?
    end

    def update_customer_has_new_notification
        Customer.all.each do |customer|
            customer.update_column(:has_new_notification, true)
        end
    end

    def create_push_notification
        FirebasePushNotification.new(self.title, self.description, self.image)
    end

    def delete_offer
        offer = Offer.find(offer_id)
        offer.destroy
    end
end
