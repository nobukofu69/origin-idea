require "test_helper"

class TalkroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get talkrooms_index_url
    assert_response :success
  end

  test "should get show" do
    get talkrooms_show_url
    assert_response :success
  end
end
