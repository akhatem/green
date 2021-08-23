# == Schema Information
#
# Table name: push_notifications
#
#  id              :bigint           not null, primary key
#  title           :string
#  description     :string
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :string
#
class PushNotification < ApplicationRecord

    validates :title, presence: true
    validates :description, presence: true
    validates :image, presence: true
    validates :notification_id, presence: true


end
