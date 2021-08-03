# == Schema Information
#
# Table name: settings
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  key         :string
#
require "test_helper"

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
