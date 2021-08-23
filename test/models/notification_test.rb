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
require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
