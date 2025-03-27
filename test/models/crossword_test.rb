require "test_helper"

class CrosswordTest < ActiveSupport::TestCase
  let(:latest) { crosswords.latest }
  let(:penultimate) { crosswords.penultimate }

  describe "#next" do
    it "returns the next crossowrd" do
      expect(penultimate.next).must_equal latest
    end
  end

  describe "#previous" do
    it "returns the previous crossowrd" do
      expect(latest.previous).must_equal penultimate
    end
  end
end
