# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  role_id             :bigint           not null
#  branch_id           :bigint
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
