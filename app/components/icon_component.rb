class IconComponent < BaseComponent
  attr_reader :name, :html_attrs

  def initialize(name:, **html_attrs)
    @name = name.to_s.dasherize
    @class_names = html_attrs[:class]
    @html_attrs = html_attrs.except(:class)
  end

  def class_names
    helpers.class_names(["icon", @class_names])
  end
end
