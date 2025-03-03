class QuickCrosswordsController < ApplicationController
  before_action :assign_latest
  before_action :assign_crossword, only: [:show]
  before_action :assign_related, only: [:show]

  def index
    redirect_to quick_crossword_path(@latest)
  end

  def show
  end

  private

  def assign_crossword
    @crossword = Crossword.quick.find_by!(slug: params[:slug]).decorate
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new "Crossword `#{params[:slug]}` not found"
  end

  def assign_latest
    @latest = Crossword.latest(:quick)
  end

  def assign_related
    @next = @crossword.next || @crossword
    @previous = @crossword.previous || @crossword
    @random = Crossword.random(:quick)
  end
end
