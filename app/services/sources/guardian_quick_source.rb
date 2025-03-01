module Sources
  class GuardianQuickSource < CrosswordSource
    include HTTParty

    source_name :guardian_quick

    base_uri "www.theguardian.com"

    class << self
      def latest
        response = get("/crosswords/series/quick")
        html = Nokogiri::HTML(response.body)
        links = html.css("a[href^='/crosswords/quick/']")
        paths = links.map { |link| link.attribute("href").value.split("#").first }
        paths.uniq.sort.reverse.map { {path: _1} }
      rescue
        []
      end

      def fetch(path:)
        response = get(path)
        if response.success?
          html = Nokogiri::HTML(response.body)
          json_data = html.css("[data-crossword-data]")&.first&.attribute("data-crossword-data")&.value
          return parse_json(json_data) if json_data&.strip&.present?
        end

        raise StandardError.new "Failed to fetch crossword data"
      end

      def import(crossword_data)
        Crossword.find_or_create_by(provider_name: source_name, provider_reference: crossword_data[:id]) do |crossword|
          crossword.crossword_type = crossword_data[:crossword_type]
          crossword.column_count = Integer(crossword_data.dig(:dimensions, :cols))
          crossword.row_count = Integer(crossword_data.dig(:dimensions, :rows))
          crossword.provider_published_on = Time.zone.at(crossword_data[:date] / 1000)
          crossword.entries = crossword_data[:entries]
        end
      end

      private

      def parse_json(json_str)
        JSON.parse(json_str).deep_transform_keys do |key|
          key.underscore.to_sym
        end
      end
    end
  end
end
