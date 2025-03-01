class CrosswordCellComponent < BaseComponent
  attr_reader :id, :x, :y, :number, :parent_entry_ids, :size, :solution

  def initialize(id:, x:, y:, parent_entries:, size:, solution:, number: nil)
    @id = id
    @x = x
    @y = y
    @current_id = number
    @parent_entry_ids = parent_entries
    @size = size
    @solution = solution
  end

  def number_text_height = 9
end
