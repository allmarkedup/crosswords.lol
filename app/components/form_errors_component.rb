class FormErrorsComponent < BaseComponent
  attr_reader :errors

  def initialize(errors:)
    @errors = errors
  end

  def render?
    errors.any?
  end
end
