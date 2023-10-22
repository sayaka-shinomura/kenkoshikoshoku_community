require "test_helper"

class Admin::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_requests_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_requests_edit_url
    assert_response :success
  end
end
