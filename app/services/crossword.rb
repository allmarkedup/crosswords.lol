class Crossword
  def initialize(data)
    @data = data
  end

  def column_count
    dimensions[:cols]
  end

  def row_count
    dimensions[:rows]
  end

  def to_json = @data.to_json

  private

  def respond_to_missing?(method_name, include_private = false)
    @data.key?(method_name) || super
  end

  def method_missing(method_name, *)
    @data.fetch(method_name) do
      super
    end
  end
end
