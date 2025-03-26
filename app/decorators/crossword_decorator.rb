class CrosswordDecorator < Draper::Decorator
  delegate_all

  def formatted_date
    published_at.strftime("%-d/%-m/%y")
  end

  def entries
    object.entries.map(&:deep_symbolize_keys).map(&:to_dot)
  end

  def clues
    entries.map { _1.slice(:id, :clue, :number, :direction).to_dot }
  end

  def puzzle_data_json
    {id:, entries:}.to_json
  end

  def provider_url
    "https://guardian.co.uk/crosswords/quick/#{number}"
  end

  def cells_display_data(cell_size)
    cells = []
    entries.each do |entry|
      start_x, start_y = start_position(entry, cell_size)

      entry[:length].times do |i|
        number = entry.number if i == 0

        if entry.direction == "across"
          x = start_x + (i * cell_size)
          y = start_y
          coordinate_x = entry.dig(:position, :x) + i
          coordinate_y = entry.dig(:position, :y)
        elsif entry.direction == "down"
          x = start_x
          y = start_y + (i * cell_size)
          coordinate_x = entry.dig(:position, :x)
          coordinate_y = entry.dig(:position, :y) + i
        end

        id = "cell-#{coordinate_x}-#{coordinate_y}"
        cell = cells.find { _1[:id] == id }

        if cell
          cell[:parent_entries] << entry.id
          cell[:number] = number if cell[:number].blank?
        else
          cells.push({id:, number:, x:, y:, parent_entries: [entry.id], solution: entry.solution[i]})
        end
      end
    end
    cells.sort_by { [_1[:x], _1[:y]] }.map(&:to_dot)
  end

  def separators_display_data(cell_size)
    separators = []
    entries.each do |entry|
      start_x, start_y = start_position(entry, cell_size)

      entry.separator_locations.flat_map { _2 }.each do |position|
        if entry.direction == "across"
          separators << {
            x: start_x + (position * cell_size) - 1,
            y: start_y,
            height: cell_size,
            width: 1
          }
        elsif entry.direction == "down"
          separators << {
            x: start_x,
            y: start_y + (position * cell_size) - 1,
            width: cell_size,
            height: 1
          }
        end
      end
    end
    separators.map(&:to_dot)
  end

  private

  def start_position(entry, cell_size)
    start_x = (entry.dig(:position, :x) * cell_size) + 1
    start_y = (entry.dig(:position, :y) * cell_size) + 1
    [start_x, start_y]
  end
end
