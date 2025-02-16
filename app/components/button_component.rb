class ButtonComponent < BaseComponent
  attr_reader :label, :alt, :confirm, :click, :button_attrs

  renders_one :icon, "IconComponent"

  def initialize(label: nil, alt: nil, icon: nil, confirm: false, theme: nil, click: nil, **button_attrs)
    @label = label
    @alt = alt
    @icon_name = icon
    @theme = theme
    @confirm = confirm
    @class_names = button_attrs[:class]
    @click = click
    @button_attrs = button_attrs.except(:class)
  end

  def before_render
    with_icon(name: @icon_name) if @icon_name
  end

  def class_names
    helpers.class_names([
      "button",
      ("button--with-icon" if @icon_name),
      ("button--with-label" if @label),
      ("button--#{@theme}" if @theme),
      @class_names
    ])
  end

  def confirmable?
    !!@confirm
  end
end
