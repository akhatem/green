require "test_helper"

class System::RolesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_roles_index_url
    assert_response :success
  end
end
