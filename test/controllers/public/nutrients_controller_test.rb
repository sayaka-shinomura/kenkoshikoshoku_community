require "test_helper"

class Public::NutrientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_nutrients_index_url
    assert_response :success
  end

  test "should get show" do
    get public_nutrients_show_url
    assert_response :success
  end
end
