require "test_helper"

class Public::WantToMakeListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_want_to_make_lists_index_url
    assert_response :success
  end
end
