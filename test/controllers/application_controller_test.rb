require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  describe "#index" do
    it "redirects to latest crossword" do
      visit root_url

      page.current_path.must_equal crossword_path(crosswords.latest)
    end
  end
end
