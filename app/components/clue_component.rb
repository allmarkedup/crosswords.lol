class ClueComponent < BaseComponent
  attr_reader :id

  def initialize(id:, clue:, number:, direction:)
    @id = id
    @clue = clue
    @current_id = number
    @direction = direction
  end

  def reference
    "#{@current_id}#{@direction.first.downcase}"
  end
end
