class PuzzleComponent < BaseComponent
  renders_one :header
  renders_one :board
  renders_one :cluebar
  renders_one :keyboard

  attr_reader :id, :entries

  def initialize(id:, entries:)
    @id = id
    @entries = entries
  end
end
