require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
  describe "#about" do
    it "shows the about page" do
      visit about_page_path

      expect(page).must_have_css(%([data-page-id="about"]))
    end
  end

  describe "#settings" do
    it "shows the settings page" do
      visit settings_page_path

      expect(page).must_have_css(%([data-page-id="settings"]))
    end
  end
end
