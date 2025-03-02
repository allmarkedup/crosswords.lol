class Crossword < ApplicationRecord
  serialize :entries, coder: JsonCoder
  attribute :slug, :string, default: -> { SlugGenerator.generate }

  def to_param
    slug
  end
end
