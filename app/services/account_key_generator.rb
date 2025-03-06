class AccountKeyGenerator
  class << self
    def generate
      emotion = Faker::Emotion.adjective
      demonym = Faker::Demographic.demonym
      animal = Faker::Creature::Animal.name
      position = Faker::Job.position
      [emotion, demonym, animal, position].join("-").parameterize.downcase
    end
  end
end
