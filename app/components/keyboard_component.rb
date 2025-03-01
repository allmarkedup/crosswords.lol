class KeyboardComponent < BaseComponent
  def initialize
  end

  def input_keys
    [
      %w[Q W E R T Y U I O P],
      %w[A S D F G H J K L],
      %w[Z X C V B N M]
    ]
  end

  def actions
    [
      [
        {
          event: "action:check-word",
          label: "Check",
          icon: :check,
          confirm: false,
          attrs: {":disabled": "$puzzle.finished"}
        },
        {
          event: "action:check-all",
          label: "Check all",
          icon: :check_check,
          confirm: false,
          attrs: {":disabled": "$puzzle.finished"}
        }
      ],
      [
        {
          event: "action:reveal-letter",
          label: "Reveal letter",
          icon: :view,
          confirm: false,
          attrs: {":disabled": "$puzzle.finished"}
        },
        {
          event: "action:reveal-word",
          label: "Reveal word",
          icon: :eye,
          confirm: "Sure?",
          attrs: {":disabled": "$puzzle.finished"}
        },
        {
          event: "action:reveal-all",
          label: "Reveal all",
          icon: :zap,
          confirm: "Sure?",
          attrs: {":disabled": "$puzzle.finished"}
        }
      ],
      [
        {
          event: "action:reset",
          label: "Reset",
          icon: :trash_2,
          confirm: "Sure?"
        },
        {
          event: "timer:start",
          label: "Start timer",
          icon: :play,
          confirm: false,
          attrs: {
            "x-show": "!$puzzle.state.timer?.running",
            ":disabled": "$puzzle.finished"
          }
        },
        {
          event: "timer:stop",
          label: "Pause timer",
          icon: :pause,
          confirm: false,
          attrs: {
            "x-show": "$puzzle.state.timer?.running",
            ":disabled": "$puzzle.finished",
            "x-cloak": true
          }
        }
      ]
    ].map { _1.map(&:to_dot) }
  end
end
