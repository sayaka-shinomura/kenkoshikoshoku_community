require "test_helper"

class Public::EffectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_effects_index_url
    assert_response :success
  end

  test "should get show" do
    get public_effects_show_url
    assert_response :success
  end
end
