# == Schema Information
#
# Table name: sizes
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  price      :decimal(2, )     not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class SizeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
