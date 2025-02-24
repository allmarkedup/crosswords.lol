class PuzzleComponent < BaseComponent
  renders_one :crossword, "CrosswordComponent"
  renders_one :cluebar, "CluebarComponent"
  renders_one :keyboard, "KeyboardComponent"

  renders_one :older_link, "LinkComponent"
  renders_one :newer_link, "LinkComponent"
  renders_one :random_link, "LinkComponent"

  attr_reader :id, :number, :entries

  def initialize(id:, date:, number:, entries:)
    @id = id
    @number = number
    @date = date
    @entries = entries
  end

  def date
    @date.strftime("%-d/%-m/%y")
  end
end
