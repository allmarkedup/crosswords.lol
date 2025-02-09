class KeyboardActionComponent < ViewComponent::Base
  attr_reader :label, :action, :confirm, :danger, :icon

  def initialize(label:, action:, confirm: false, icon: nil, danger: false)
    @label = label
    @action = action
    @confirm = confirm
    @danger = danger
    @icon = icon.to_s.tr("_", "-")
  end

  def actions
    Array(@action)
  end
end
