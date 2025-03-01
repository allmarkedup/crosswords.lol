class CrosswordIntent
  attr_reader :args, :kwargs

  def initialize(*args, **kwargs)
    @args = args
    @kwargs = kwargs
    @data = nil
  end

  def data
    @data || hydrate
  end

  def identifier
    self.class.identifier
  end

  class << self
    def identifier(identifier = nil)
      @identifier = identifier if identifier
      @identifier
    end

    def resolve(intent_identifier)
      "#{intent_identifier}_crossword_intent".camelize.constantize
    end
  end
end
