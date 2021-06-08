# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  image_data :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class BrandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
