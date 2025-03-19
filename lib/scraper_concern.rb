module ScraperConcern
  extend ActiveSupport::Concern

  included do
    include HTTParty
  end

  def get_html(path)
    self.class.get_html(path)
  end

  def parse_json(json_str)
    JSON.parse(json_str).deep_transform_keys do |key|
      key.underscore.to_sym
    end
  end

  class_methods do
    def get_html(path)
      response = get(path)
      if response.success?
        Nokogiri::HTML(response.body)
      else
        raise CrosswordProviderError, "Failed to fetch HTML"
      end
    end
  end
end
