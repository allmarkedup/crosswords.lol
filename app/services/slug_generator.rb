require "digest/sha1"
require "faker"

class SlugGenerator < ApplicationService
  def call
    input = Faker::String.random(length: 8)
    Digest::SHA1.hexdigest(input)[0..5].parameterize.downcase
  end
end
