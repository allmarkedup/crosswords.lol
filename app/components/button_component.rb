class ButtonComponent < BaseComponent
  attr_reader :label, :alt, :confirm, :click, :href, :html_attrs

  renders_one :icon, "IconComponent"

  def initialize(label: nil, alt: nil, icon: nil, confirm: false, theme: nil, click: nil, href: nil, **html_attrs)
    @label = label
    @alt = alt
    @icon_name = icon
    @theme = theme
    @confirm = confirm
    @click = click
    @href = href
    @class_names = html_attrs[:class]
    @html_attrs = html_attrs.except(:class)
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

  def button_tag
    @href ? :a : :button
  end
end
