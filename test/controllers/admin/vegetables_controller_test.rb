require "test_helper"

class Admin::VegetablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_vegetables_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_vegetables_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_vegetables_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_vegetables_edit_url
    assert_response :success
  end
end
