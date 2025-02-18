class PuzzleComponent < BaseComponent
  renders_one :header, "HeaderComponent"
  renders_one :crossword, "CrosswordComponent"
  renders_one :cluebar, "CluebarComponent"
  renders_one :keyboard, "KeyboardComponent"
  renders_one :coda, "CodaComponent"

  attr_reader :id, :entries

  def initialize(id:, entries:)
    @id = id
    @entries = entries
  end
end
