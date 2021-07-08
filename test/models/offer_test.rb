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
#  is_default  :boolean          default(FALSE)
#
require "test_helper"

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
