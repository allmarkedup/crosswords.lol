class ClueComponent < BaseComponent
  attr_reader :id

  def initialize(id:, clue:, number:, direction:)
    @id = id
    @clue = clue
    @number = number
    @direction = direction
  end

  def reference
    "#{@number}#{@direction.first.downcase}"
  end
end
