class PuzzleComponent < BaseComponent
  renders_one :crossword, "CrosswordComponent"
  renders_one :cluebar, "CluebarComponent"
  renders_one :cluesheet, "CluesheetComponent"
  renders_one :keyboard, "KeyboardComponent"

  renders_one :older_link, "LinkComponent"
  renders_one :newer_link, "LinkComponent"
  renders_one :random_link, "LinkComponent"

  attr_reader :answer

  delegate :id, :entries, to: :@crossword

  def initialize(crossword:, answer: nil)
    @crossword = crossword
    @answer = answer
  end

  def date
    @crossword.published_at.strftime("%-d/%-m/%y")
  end

  def provider_url
    "https://guardian.co.uk/crosswords/quick/#{@crossword.number}"
  end
end
