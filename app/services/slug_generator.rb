require "digest/sha1"
require "faker"

class SlugGenerator < ApplicationService
  def initialize(input = Faker::String.random(length: 8))
    @input = input
  end

  def call
    Digest::SHA1.hexdigest(@input)[0..6].parameterize.downcase
  end
end
