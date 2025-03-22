require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  describe "#index" do
    it "redirects to latest crossword" do
      get root_url
      assert_redirected_to crossword_url(crosswords.latest)
    end
  end
end
