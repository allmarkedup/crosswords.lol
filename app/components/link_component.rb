class LinkComponent < ViewComponent::Base
  attr_reader :args, :html_attrs

  def initialize(*args, **html_attrs)
    @args = args
    @html_attrs = html_attrs
  end

  erb_template <<~ERB
    <%= helpers.link_to(*@args, **@html_attrs) %>
  ERB
end
