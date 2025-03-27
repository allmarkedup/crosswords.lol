require "test_helper"

class CrosswordTest < ActiveSupport::TestCase
  let(:latest) { crosswords.latest }
  let(:penultimate) { crosswords.penultimate }

  describe "#next" do
    it "returns the next crossowrd" do
      penultimate.next.must_equal latest
    end
  end

  describe "#previous" do
    it "returns the previous crossowrd" do
      latest.previous.must_equal penultimate
    end
  end
end
