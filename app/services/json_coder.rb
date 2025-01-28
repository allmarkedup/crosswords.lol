class JsonCoder
  def self.load(str)
    str.nil? ? nil : JSON.parse(str).with_indifferent_access
  end

  def self.dump(data)
    data.nil? ? "{}" : JSON.generate(data)
  end
end
