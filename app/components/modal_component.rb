class ModalComponent < BaseComponent
  attr_reader :id, :title, :blocking, :html_attrs

  def initialize(id:, title:, blocking: false, **html_attrs)
    @id = id
    @title = title
    @blocking = blocking
    @class_names = html_attrs[:class]
    @html_attrs = html_attrs.except(:class)
  end

  def class_names
    helpers.class_names(["modal", @class_names, {blocking: @blocking}])
  end
end
