require "faker"

class SlugGenerator
  class << self
    def generate
      emotion = Faker::Emotion.adjective
      hipster = Faker::Hipster.words(number: 2, spaces_allowed: false)
      [emotion, hipster].join("-").parameterize.downcase
    end
  end
end
