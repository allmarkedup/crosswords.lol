class ActionbarButtonComponent < ViewComponent::Base
  attr_reader :action, :confirm_text, :danger, :icon

  def initialize(action:, confirm_text:, icon: nil, danger: false)
    @action = action
    @confirm_text = confirm_text
    @danger = danger
    @icon = icon.to_s.tr("_", "-")
  end
end
