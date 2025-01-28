class ActionbarButtonComponent < ViewComponent::Base
  renders_one :icon

  attr_reader :action, :confirm_text, :danger

  def initialize(action:, confirm_text:, danger: false)
    @action = action
    @confirm_text = confirm_text
    @danger = danger
  end
end
