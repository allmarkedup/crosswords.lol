require "test_helper"

class SlugGeneratorTest < ActiveSupport::TestCase
  it "generates a suitable slug" do
    slug = SlugGenerator.call

    assert_kind_of(String, slug)
    assert_equal(6, slug.length)
    assert_equal(slug, slug.downcase)
  end
end
