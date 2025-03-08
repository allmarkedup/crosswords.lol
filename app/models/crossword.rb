class Crossword < ApplicationRecord
  has_many :answers

  serialize :entries, coder: JsonCoder
  attribute :slug, :string, default: -> { SlugGenerator.generate }

  scope :quick, -> { where(crossword_type: "quick") }

  alias_attribute :date, :provider_published_on

  def next
    self.class
      .where(crossword_type: crossword_type)
      .where("provider_published_on > ?", provider_published_on).order(provider_published_on: :asc).first
  end

  def previous
    self.class
      .where(crossword_type: crossword_type)
      .where("provider_published_on < ?", provider_published_on).order(provider_published_on: :asc).last
  end

  def to_param
    slug
  end

  class << self
    def random(type = nil)
      if type
        where(crossword_type: type.to_s).order("RANDOM()").first
      else
        order("RANDOM()").first
      end
    end

    def latest(type = nil)
      if type
        where(crossword_type: type.to_s).order(provider_published_on: :asc).last
      else
        order(provider_published_on: :asc).last
      end
    end
  end
end
