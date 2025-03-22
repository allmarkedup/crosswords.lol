require "test_helper"

class AccountKeyGeneratorTest < ActiveSupport::TestCase
  it "generates a suitable account key" do
    key = AccountKeyGenerator.call

    assert_kind_of(String, key)
    assert_includes([4, 5], key.split("-").length)
    assert_equal(key, key.downcase)
  end
end
