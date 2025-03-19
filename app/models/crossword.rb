class Crossword < ApplicationRecord
  has_many :answers

  serialize :entries, coder: JsonCoder
  attribute :slug, :string, default: -> { SlugGenerator.call }

  def next
    self.class
      .where("number > ?", number).order(number: :asc).first
  end

  def previous
    self.class
      .where("number < ?", number).order(number: :asc).last
  end

  def to_param
    number.to_s
  end

  class << self
    def random
      order("RANDOM()").first
    end

    def latest
      order(number: :desc).first
    end
  end
end
