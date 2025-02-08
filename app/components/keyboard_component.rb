class KeyboardComponent < ViewComponent::Base
  def layout
    [
      %w[Q W E R T Y U I O P],
      %w[A S D F G H J K L],
      %w[TIMER Z X C V B N M DEL]
    ]
  end
end
