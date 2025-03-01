class PuzzleComponent < BaseComponent
  renders_one :crossword, "CrosswordComponent"
  renders_one :cluebar, "CluebarComponent"
  renders_one :keyboard, "KeyboardComponent"

  renders_one :older_link, "LinkComponent"
  renders_one :newer_link, "LinkComponent"
  renders_one :random_link, "LinkComponent"

  attr_reader :id, :entries

  def initialize(id:, entries:)
    @id = id
    @entries = entries
  end

  def date
    @date.strftime("%-d/%-m/%y")
  end
end
