class CrosswordProvider
  include ScraperConcern

  base_uri "www.theguardian.com"

  class << self
    def latest(max = 5)
      html = get_html("/crosswords/series/quick")
      links = html.css("a[href^='/crosswords/quick/']")
      if links.any?
        paths = links.map { |link| link.attribute("href").value.split("#").first }
        paths.uniq.sort.reverse.take(max).map do |path|
          CrosswordIntent.new(path)
        end
      else
        raise CrosswordProviderError, "Failed to look up latest crosswords"
      end
    end
  end
end
