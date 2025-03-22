require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  describe "#about" do
    it "shows the about page" do
      get about_page_url

      assert_response :success
      assert_dom ".page-title", "What's this?"
    end
  end

  describe "#settings" do
    it "shows the settings page" do
      get settings_page_url

      assert_response :success
      assert_dom ".page-title", "Settings"
    end
  end
end
