class Crossword < ApplicationRecord
  serialize :data, coder: JsonCoder
end
