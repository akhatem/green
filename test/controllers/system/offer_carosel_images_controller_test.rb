require "test_helper"

class System::OfferCaroselImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_offer_carosel_images_index_url
    assert_response :success
  end

  test "should get show" do
    get system_offer_carosel_images_show_url
    assert_response :success
  end
end
