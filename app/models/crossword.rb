class Crossword < ApplicationRecord
  serialize :data, coder: JsonCoder

  delegate_missing_to :data

  def column_count
    data[:dimensions][:cols]
  end

  def row_count
    data[:dimensions][:rows]
  end
end
