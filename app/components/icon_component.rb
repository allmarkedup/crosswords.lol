class IconComponent < BaseComponent
  attr_reader :name

  def initialize(name:)
    @name = name.to_s.dasherize
  end
end
