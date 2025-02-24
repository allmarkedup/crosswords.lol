class ModalComponent < BaseComponent
  attr_reader :id, :title, :blocking, :show, :close, :html_attrs

  def initialize(id:, title:, show:, close:, blocking: false, **html_attrs)
    @id = id
    @title = title
    @show = show
    @close = close
    @blocking = blocking
    @class_names = html_attrs[:class]
    @html_attrs = html_attrs.except(:class)
  end

  def class_names
    helpers.class_names(["modal", @class_names, {blocking: @blocking}])
  end
end
