require "test_helper"

class SyncControllerTest < ActionDispatch::IntegrationTest
  test "should show page to create new sync key" do
    get new_sync_url

    assert_response :success
  end
end
