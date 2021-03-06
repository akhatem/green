# == Schema Information
#
# Table name: offers
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  state       :integer          default("valid"), not null
#  start_at    :datetime         not null
#  end_at      :datetime         not null
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
    validates :image, presence: true

    validate :dates
    validate :state_of_offer
    
    mount_uploader :image, OfferImageUploader
    
    enum state: { expired: 0, valid: 1 }, _prefix: :state

    after_create :create_notification
    before_destroy :destroy_notification

    def self.search_by(search_term)
        where(state: search_term.downcase)
        .or(where("id = ?", search_term.to_i))
    end

    private
    
    def dates
        self.errors.add(:end_at, :invalid) if end_at.present? && start_at.present? && end_at < start_at
    end

    def state_of_offer
        self.errors.add(:state, :invalid) if self.end_at.to_datetime < Time.current.to_datetime and self.state.eql?("valid")
    end

    def create_notification
        # puts "================> HERE"
        text = <<-TEXT
#{self.description}. \nfrom #{self.start_at.strftime("%l:%M %p - %d/%m/%Y")} - to #{self.end_at.strftime("%l:%M %p - %d/%m/%Y")}
        TEXT
        # puts "================> text: #{text}"

        Notification.create(offer_id: self.id, title: self.title, description: text, create_date: Date.today, image: self.image)
        # puts "================> notification valid?: #{notification.valid?}"
    end

    def destroy_notification
        notification = Notification.find_by(offer_id: self.id)
        notification.destroy
    end
end
