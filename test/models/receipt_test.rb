# == Schema Information
#
# Table name: receipts
#
#  id          :bigint           not null, primary key
#  customer_id :bigint           not null
#  branch_id   :bigint           not null
#  user_id     :bigint           not null
#  number      :string           not null
#  total_price :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class ReceiptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
