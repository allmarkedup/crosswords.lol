class CrosswordDecorator < Draper::Decorator
  delegate_all

  def id
    data.id.gsub("crosswords/", "").parameterize
  end

  def style
    id.split("-").first
  end

  def date
    Time.zone.at(data.date / 1000).to_datetime
  end

  def entries
    data[:entries].map(&:deep_symbolize_keys).map(&:to_dot)
  end

  def data
    object.data.to_dot
  end
end
