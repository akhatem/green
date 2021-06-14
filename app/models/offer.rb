# == Schema Information
#
# Table name: offers
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  state       :integer          default("valid"), not null
#  start_at    :date             not null
#  end_at      :date             not null
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Offer < ApplicationRecord

    validates :title, presence: true
    validates :description, presence: true
    validates :state, presence: true
    validates :start_at, presence: true
    validates :end_at, presence: true

    mount_uploader :image, OfferImageUploader
    
    validate :dates
    
    enum state: [ :expired, :valid ], _prefix: :state


    after_save :create_notification
    
    def dates
        self.errors.add(:end_at, :invalid) if end_at.present? && start_at.present? && end_at < start_at
    end


    private
    
    def update_state
        if (self.end_at < Date.today) && self.state == "valid"
            CheckOfferExpiryWorker.perform_single_async(self.id)
        end
    end

    def create_notification
        text = <<-TEXT
#{self.description}. from #{self.start_at} - to #{self.end_at}
        TEXT

        Notification.create(offer_id: self.id, title: self.title, description: text, create_date: Date.today)
    end
end
