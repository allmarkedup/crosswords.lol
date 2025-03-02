class Crossword < ApplicationRecord
  serialize :entries, coder: JsonCoder
  attribute :slug, :string, default: -> { SlugGenerator.generate }

  def next
    self.class.where("provider_published_on > ?", provider_published_on).order(provider_published_on: :asc).first
  end

  def previous
    self.class.where("provider_published_on < ?", provider_published_on).order(provider_published_on: :asc).last
  end

  def to_param
    slug
  end

  class << self
    def random
      order("RANDOM()").first
    end
  end
end
