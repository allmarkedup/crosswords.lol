class CrosswordCellComponent < ViewComponent::Base
  attr_reader :id, :x, :y, :number, :cell_size, :entries

  def initialize(id:, x:, y:, entries:, cell_size:, number: nil)
    @id = id
    @x = x
    @y = y
    @number = number
    @entries = entries
    @cell_size = cell_size
  end

  def number_text_height = 9
end
