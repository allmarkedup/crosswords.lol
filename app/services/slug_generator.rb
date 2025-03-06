require "digest/sha1"
require "faker"

class SlugGenerator
  class << self
    def generate(input = Faker::String.random(length: 8))
      Digest::SHA1.hexdigest(input)[0..6].parameterize.downcase
    end
  end
end
