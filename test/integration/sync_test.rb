require "test_helper"

class SyncTest < ActionDispatch::IntegrationTest
  describe "#new" do
    it "shows the new sync key page" do
      visit new_sync_path

      expect(page).must_have_css(%([data-page-id="sync/new"]))
    end
  end
end
