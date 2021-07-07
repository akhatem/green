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
    # after_create :set_offer_type
    
    def dates
        self.errors.add(:end_at, :invalid) if end_at.present? && start_at.present? && end_at < start_at
    end

    def self.search_by(search_term)
        where(state: search_term)
        # where("id = ?", search_term.to_i)
        
    end

    private

    def create_notification
        if self.state.eql?(1)
        text = <<-TEXT
#{self.description}. \nfrom #{self.start_at} - to #{self.end_at}
        TEXT
        Notification.create(offer_id: self.id, title: self.title, description: text, create_date: Date.today)
        end
    end
end
