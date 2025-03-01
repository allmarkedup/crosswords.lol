class JsonCoder
  def self.load(str)
    data = str.nil? ? nil : JSON.parse(str)
    if data.is_a?(Array)
      data.map { _1.with_indifferent_access }
    elsif data
      data.with_indifferent_access
    end
  end

  def self.dump(data)
    data.nil? ? "{}" : JSON.generate(data)
  end
end
