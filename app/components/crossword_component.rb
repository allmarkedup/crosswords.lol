class CrosswordComponent < ViewComponent::Base
  renders_many :cells, ->(**cell) do
    CrosswordCellComponent.new(cell_size: @cell_size, **cell)
  end

  renders_many :separators, ->(**kwargs) do
    tag.rect(**kwargs, class: "crossword-separator")
  end

  attr_reader :cell_size

  def initialize(crossword:)
    @crossword = crossword
    @cell_size = 30
  end

  def id
    @crossword.number
  end

  def entries
    @crossword.data[:entries]
  end

  def view_box
    "0 0 #{width} #{height}"
  end

  def width
    (cell_size * @crossword.column_count) + 2
  end

  def height
    (cell_size * @crossword.row_count) + 2
  end

  private

  def cells_data
    data = []
    entries.each do |entry|
      start_x, start_y = start_position(entry)

      entry[:length].times do |i|
        number = entry[:number] if i == 0

        if entry[:direction] == "across"
          x = start_x + (i * @cell_size)
          y = start_y
          coordinate_x = entry.dig(:position, :x) + i
          coordinate_y = entry.dig(:position, :y)
        elsif entry[:direction] == "down"
          x = start_x
          y = start_y + (i * @cell_size)
          coordinate_x = entry.dig(:position, :x)
          coordinate_y = entry.dig(:position, :y) + i
        end

        id = "cell-#{coordinate_x}-#{coordinate_y}"
        cell = data.find { _1[:id] == id }

        if cell
          cell[:entries] << entry[:id]
          cell[:number] = number if cell[:number].blank?
        else
          data.push({id:, number:, x:, y:, entries: [entry[:id]]})
        end
      end
    end
    data.sort_by { [_1[:x], _1[:y]] }
  end

  def separators_data
    data = []
    entries.each do |entry|
      start_x, start_y = start_position(entry)

      entry[:separator_locations].flat_map { _2 }.each do |position|
        if entry[:direction] == "across"
          data << {
            x: start_x + (position * @cell_size) - 1,
            y: start_y,
            height: @cell_size,
            width: 1
          }
        elsif entry[:direction] == "down"
          data << {
            x: start_x,
            y: start_y + (position * @cell_size) - 1,
            width: @cell_size,
            height: 1
          }
        end
      end
    end
    data
  end

  def start_position(entry)
    start_x = (entry.dig(:position, :x) * @cell_size) + 1
    start_y = (entry.dig(:position, :y) * @cell_size) + 1
    [start_x, start_y]
  end

  def before_render
    cells_data.each { with_cell(**_1) }
    separators_data.each { with_separator(**_1) }
  end
end
