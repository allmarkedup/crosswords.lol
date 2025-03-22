require "test_helper"

class CrosswordTest < ActiveSupport::TestCase
  let(:latest) { crosswords.latest }
  let(:penultimate) { crosswords.penultimate }

  describe "#next" do
    it "returns the next crossowrd" do
      assert_equal(latest, penultimate.next)
    end
  end

  describe "#previous" do
    it "returns the previous crossowrd" do
      assert_equal(penultimate, latest.previous)
    end
  end
end
