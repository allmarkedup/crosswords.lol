class CrosswordDecorator < Draper::Decorator
  delegate_all

  def entries
    object.entries.map(&:deep_symbolize_keys).map(&:to_dot)
  end
end
