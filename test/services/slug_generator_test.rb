require "test_helper"

class SlugGeneratorTest < ActiveSupport::TestCase
  it "generates a suitable slug" do
    slug = SlugGenerator.call

    expect(slug).must_be_kind_of String
    expect(slug.length).must_equal 6
    expect(slug).must_equal slug.downcase
  end
end
