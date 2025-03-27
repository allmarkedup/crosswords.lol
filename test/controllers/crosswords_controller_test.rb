require "test_helper"

class CrosswordsControllerTest < ActionDispatch::IntegrationTest
  describe "#show" do
    let(:crossword) { crosswords.random }

    it "is successful" do
      visit crossword_url(crossword)

      page.must_have_css(".crossword")
    end
  end
end
