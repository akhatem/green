# == Schema Information
#
# Table name: points_movements
#
#  id             :bigint           not null, primary key
#  customer_id    :bigint           not null
#  branch_id      :bigint           not null
#  redeemed       :integer          default(0)
#  earned         :integer          default(0)
#  date_time      :datetime         not null
#  total          :integer          default(0)
#  current_points :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
require "test_helper"

class PointsMovementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
