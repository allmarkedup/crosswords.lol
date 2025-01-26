module Scrapers
  class Guardian
    include HTTParty
    parser ::Parsers::Html

    base_uri "www.theguardian.com/crosswords"

    def self.fetch(type, id)
      response = get("/#{type}/#{id}")
      html = Nokogiri::HTML(response.body)
      json_data_str = html.css("[data-crossword-data]").first.attribute("data-crossword-data").value
      parse_json(json_data_str)
    end

    private

    def self.parse_json(json_str)
      JSON.parse(json_str).deep_transform_keys do |key|
        key.underscore.to_sym
      end
    end
  end
end
