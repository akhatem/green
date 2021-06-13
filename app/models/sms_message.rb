# == Schema Information
#
# Table name: sms_messages
#
#  id         :bigint           not null, primary key
#  mobile     :string
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SmsMessage < ApplicationRecord
    validates :message, presence: true
end
