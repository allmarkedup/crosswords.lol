class Crossword < ApplicationRecord
  serialize :entries, coder: JsonCoder
end
