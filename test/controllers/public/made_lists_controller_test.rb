require "test_helper"

class Public::MadeListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_made_lists_index_url
    assert_response :success
  end
end
