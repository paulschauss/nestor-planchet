require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get reply" do
    get reviews_reply_url
    assert_response :success
  end
end
