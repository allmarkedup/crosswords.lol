require "test_helper"

class AccountTest < ActiveSupport::TestCase
  let(:account) { accounts.bob }

  describe "#key" do
    it "returns an identifier key" do
      assert_kind_of(String, account.key)
    end
  end
end
