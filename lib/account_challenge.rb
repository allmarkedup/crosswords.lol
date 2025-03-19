class AccountChallenge
  def initialize(crossword_id = nil, entry_id = nil)
    @crossword_id = Integer(crossword_id) if crossword_id
    @entry_id = entry_id
  end

  def validate(solution)
    entry.solution.downcase == solution.strip.downcase.gsub(/\s+/, "").delete("-")
  end

  def crossword_name
    "##{crossword.id}"
  end

  def entry_name
    "#{entry.number} #{entry.direction}"
  end

  def clue
    entry.clue
  end

  def crossword
    @crossword ||= @crossword_id ? Crossword.find(@crossword_id) : Crossword.random
  end

  def entry
    @entry ||= if @entry_id
      crossword.entries.find { _1.id == @entry_id }
    else
      crossword.entries.sample
    end
  end

  def to_cookie_value
    [crossword.id, entry.id].join(":")
  end

  class << self
    def from_cookie(cookie_value)
      new(*cookie_value.split(":"))
    end
  end
end
