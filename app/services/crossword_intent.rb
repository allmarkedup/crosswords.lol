class CrosswordIntent
  include ScraperConcern

  base_uri "www.theguardian.com"

  attr_reader :args, :kwargs

  def initialize(*args, **kwargs)
    @args = args
    @kwargs = kwargs
    @data = nil
  end

  def data
    @data ||= fetch_data
  end

  def fetch_data
    html = get_html(path)
    json_data = html.css("[name='CrosswordComponent']")&.attribute("props")&.value&.strip
    raw_data = nil
    if json_data.present?
      raw_data = parse_json(json_data)
      normalize_data(raw_data[:data])
    else
      raise CrosswordProviderError.new("Failed to extract crossword data")
    end
  rescue => error
    raise CrosswordProviderError.new(error.to_s, {json_data:, raw_data:})
  end

  private

  def path = args[0]

  def normalize_data(raw_data)
    {
      number: raw_data[:id].delete_prefix("crosswords/quick/").to_i,
      published_at: Time.zone.at(raw_data[:date] / 1000),
      column_count: Integer(raw_data.dig(:dimensions, :cols)),
      row_count: Integer(raw_data.dig(:dimensions, :rows)),
      **raw_data.slice(:crossword_type, :entries)
    }
  end
end
