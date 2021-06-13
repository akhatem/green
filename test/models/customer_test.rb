# == Schema Information
#
# Table name: customers
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  mobile              :string           not null
#  password            :string           default(""), not null
#  password_digest     :string           default(""), not null
#  email               :string
#  token               :string
#  barcode_data        :text
#  points              :integer          default(0), not null
#  is_activated?       :boolean          default(FALSE), not null
#  verification_code   :string
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
