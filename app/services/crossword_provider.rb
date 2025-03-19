class CrosswordProvider
  include ScraperConcern

  base_uri "www.theguardian.com"

  class << self
    def latest(max = 1)
      html = get_html("/crosswords/series/quick")
      links = html.css("a[href^='/crosswords/quick/']")
      paths = []
      if links.any?
        paths = links.map { |link| link.attribute("href").value.split("#").first }
        paths = paths.uniq.sort.reverse.take(max)
        paths.map do |path|
          CrosswordIntent.new(path)
        end
      else
        raise CrosswordProviderError.new("Failed to look up latest crosswords", {links:})
      end
    rescue => error
      raise CrosswordProviderError.new(error.to_s, {links:, paths:})
    end
  end
end
