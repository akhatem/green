require "test_helper"

class System::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_customers_index_url
    assert_response :success
  end

  test "should get show" do
    get system_customers_show_url
    assert_response :success
  end
end
