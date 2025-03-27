require "test_helper"

class AccountTest < ActiveSupport::TestCase
  let(:account) { accounts.bob }

  describe "#key" do
    it "returns an identifier key" do
      account.key.must_be_kind_of String
    end
  end
end
