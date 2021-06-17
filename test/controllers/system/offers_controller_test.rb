require "test_helper"

class System::OffersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_offers_index_url
    assert_response :success
  end

  test "should get show" do
    get system_offers_show_url
    assert_response :success
  end

  test "should get edit" do
    get system_offers_edit_url
    assert_response :success
  end
end
