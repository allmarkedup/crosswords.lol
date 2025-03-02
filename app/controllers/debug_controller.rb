class DebugController < ApplicationController
  def index
    @crosswords_count = Crossword.count
    render layout: nil
  end
end
