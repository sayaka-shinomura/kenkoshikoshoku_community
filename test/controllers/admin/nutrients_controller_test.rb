require "test_helper"

class Admin::NutrientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_nutrients_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_nutrients_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_nutrients_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_nutrients_edit_url
    assert_response :success
  end
end
