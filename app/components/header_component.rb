class HeaderComponent < BaseComponent
  renders_one :newer_link, ->(href:, disabled: false) do
    helpers.link_to href, class: ["header-nav-link header-nav-link-newer", {disabled:}], "@click.prevent": "hijax" do
      icon :circle_arrow_right
    end
  end

  renders_one :older_link, ->(href:, disabled: false) do
    helpers.link_to href, class: ["header-nav-link header-nav-link-older", {disabled:}], "@click.prevent": "hijax" do
      icon :circle_arrow_left
    end
  end

  attr_reader :number

  def initialize(number:, date:)
    @number = number
    @date = date
  end

  def date
    @date.strftime("%-d/%-m/%y")
  end
end
