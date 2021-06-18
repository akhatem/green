# == Schema Information
#
# Table name: roles_permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint           not null
#  permission_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class RolesPermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
