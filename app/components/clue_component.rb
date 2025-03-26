class ClueComponent < BaseComponent
  attr_reader :id, :direction, :number

  def initialize(id:, clue:, number:, direction:)
    @id = id
    @clue = clue
    @number = number
    @direction = direction
  end
end
