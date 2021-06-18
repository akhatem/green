# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  action      :string
#  class_name  :string
#  description :text
#  is_super    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
