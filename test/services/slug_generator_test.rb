require "test_helper"

class SlugGeneratorTest < ActiveSupport::TestCase
  it "generates a suitable slug" do
    slug = SlugGenerator.call

    slug.must_be_kind_of String
    slug.length.must_equal 6
    slug.must_equal slug.downcase
  end
end
