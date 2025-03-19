class CrosswordProviderError < StandardError
  attr_reader :message, :context

  def initialize(message, context = {})
    @message = message
    @context = context
  end

  def to_s = @message
end
