module Providers
  class Guardian
    include HTTParty
    parser ::Parsers::Html

    base_uri "www.theguardian.com/crosswords"

    class << self
      def latest_id(type)
        response = get("/series/#{type}")
        html = Nokogiri::HTML(response.body)
        links = html.css("a[href^='/crosswords/#{type}/']")
        links.first.attribute("href").value.sub("/crosswords/#{type}/", "").to_i
      end

      def fetch(type, id)
        response = get("/#{type}/#{id}")
        if response.success?
          html = Nokogiri::HTML(response.body)
          json_data_str = html.css("[data-crossword-data]").first.attribute("data-crossword-data").value
          parse_json(json_data_str)
        else
          raise StandardError.new "Could not fetch crossword data"
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
