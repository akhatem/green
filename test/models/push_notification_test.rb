# == Schema Information
#
# Table name: push_notifications
#
#  id              :bigint           not null, primary key
#  title           :string
#  body            :string
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :string
#
require "test_helper"

class PushNotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
