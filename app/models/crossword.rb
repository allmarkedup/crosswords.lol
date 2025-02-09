class Crossword < ApplicationRecord
  serialize :data, coder: JsonCoder

  delegate_missing_to :data

  def date
    Time.zone.at(data[:date] / 1000).to_datetime
  end

  def column_count
    data[:dimensions][:cols]
  end

  def row_count
    data[:dimensions][:rows]
  end
end
