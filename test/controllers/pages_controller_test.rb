require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  describe "#about" do
    it "shows the about page" do
      visit about_page_url

      page.must_have_css(".page-title", text: "What's this?")
    end
  end

  describe "#settings" do
    it "shows the settings page" do
      visit settings_page_url

      page.must_have_css(".page-title", text: "Settings")
    end
  end
end
