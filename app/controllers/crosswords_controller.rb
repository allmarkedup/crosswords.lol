class CrosswordsController < ApplicationController
  before_action :assign_style
  before_action :assign_latest
  before_action :assign_crossword, only: [:show]
  before_action :assign_related, only: [:show]

  def index
    redirect_to crossword_path(@style, @latest)
  end

  def show
  end

  private

  def assign_style
    @style = params[:style] || "quick"
  end

  def assign_crossword
    @crossword = Crossword.find_by!(slug: params[:slug]).decorate
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new "Crossword `#{params[:slug]}` not found"
  end

  def assign_latest
    @latest = Crossword.last
  end

  def assign_related
    @next = @crossword.next || @crossword
    @previous = @crossword.previous || @crossword
    @random = Crossword.random
  end
end
