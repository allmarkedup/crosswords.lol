class HtmlParser < HTTParty::Parser
  def html
    Nokogiri::HTML(body)
  end
end
