module Parsers
  class Html < HTTParty::Parser
    def html
      Nokogiri::HTML(body)
    end
  end
end
