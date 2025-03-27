require "test_helper"

class AccountKeyGeneratorTest < ActiveSupport::TestCase
  it "generates a suitable account key" do
    key = AccountKeyGenerator.call

    key.must_be_kind_of String
    [4, 5].must_include key.split("-").length
    key.must_equal key.downcase
  end
end
