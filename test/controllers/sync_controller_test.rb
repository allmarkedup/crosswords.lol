require "test_helper"

class SyncControllerTest < ActionDispatch::IntegrationTest
  describe "#new" do
    it "shows the new sync key page" do
      get new_sync_url

      assert_response :success
    end
  end
end
