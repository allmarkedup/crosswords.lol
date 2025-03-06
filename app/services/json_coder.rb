class JsonCoder
  def self.load(str)
    data = str.nil? ? nil : JSON.parse(str)
    if data.is_a?(Array)
      data.map { _1.to_dot }
    elsif data
      data.to_dot
    end
  end

  def self.dump(data)
    data.nil? ? "{}" : JSON.generate(data)
  end
end
