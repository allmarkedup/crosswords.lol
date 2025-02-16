class CrosswordCellComponent < BaseComponent
  attr_reader :id, :x, :y, :number, :parent_entry_ids, :size

  def initialize(id:, x:, y:, parent_entries:, size:, number: nil)
    @id = id
    @x = x
    @y = y
    @number = number
    @parent_entry_ids = parent_entries
    @size = size
  end

  def number_text_height = 9
end
