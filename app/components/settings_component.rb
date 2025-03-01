class SettingsComponent < BaseComponent
  attr_reader :back

  def initialize(back: nil)
    @back = back
  end
end
