class CrosswordProvider
  class << self
    def resolve(provider_identifier)
      "#{provider_identifier}_crossword_provider".camelize.constantize
    end
  end
end
