require "test_helper"

class System::BrandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_brands_index_url
    assert_response :success
  end

  test "should get show" do
    get system_brands_show_url
    assert_response :success
  end

  test "should get new" do
    get system_brands_new_url
    assert_response :success
  end

  test "should get create" do
    get system_brands_create_url
    assert_response :success
  end

  test "should get edit" do
    get system_brands_edit_url
    assert_response :success
  end

  test "should get update" do
    get system_brands_update_url
    assert_response :success
  end

  test "should get destroy" do
    get system_brands_destroy_url
    assert_response :success
  end
end
