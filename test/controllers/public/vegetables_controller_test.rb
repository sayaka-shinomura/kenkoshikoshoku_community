require "test_helper"

class Public::VegetablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_vegetables_index_url
    assert_response :success
  end

  test "should get show" do
    get public_vegetables_show_url
    assert_response :success
  end
end
