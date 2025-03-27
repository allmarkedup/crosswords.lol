require "test_helper"

class SyncControllerTest < ActionDispatch::IntegrationTest
  describe "#new" do
    it "shows the new sync key page" do
      visit new_sync_url

      page.must_have_css(".page-title", text: "Sync your data")
    end
  end
end
