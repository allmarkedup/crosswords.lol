require "test_helper"

class CrosswordsTest < ActionDispatch::IntegrationTest
  describe "#show" do
    let(:crossword) { crosswords.random }

    before do
      visit crossword_path(crossword)
    end

    it "renders the puzzle with all the components" do
      within ".puzzle" do
        expect(page).must_have_css(".crossword")
        expect(page).must_have_css(".keyboard")
        expect(page).must_have_css(".cluebar")
        expect(page).must_have_css(".cluesheet", visible: false)
      end
    end
  end
end
