require "test_helper"

class CrosswordsControllerTest < ActionDispatch::IntegrationTest
  describe "#show" do
    let(:crossword) { crosswords.random }

    it "is successful" do
      get crossword_url(crossword)
      assert_response :success
    end
  end
end
