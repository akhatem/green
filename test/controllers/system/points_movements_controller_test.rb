require "test_helper"

class System::PointsMovementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_points_movements_index_url
    assert_response :success
  end

  test "should get show" do
    get system_points_movements_show_url
    assert_response :success
  end
end
