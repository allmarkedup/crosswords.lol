class CrosswordsController < ApplicationController
  before_action :assign_style
  before_action :assign_crossword, only: [:show]
  before_action :assign_latest_id
  before_action :assign_current_id

  def index
    redirect_to crossword_path(@style, @latest_id)
  end

  def show
    @next_id = (@current_id == @latest_id) ? @current_id : @current_id + 1
    @previous_id = @current_id - 1
  end

  private

  def assign_style
    @style = params[:style] || "quick"
  end

  def assign_crossword
    @crossword = Crossword.find(params[:id]).decorate
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new "Crossword ##{params[:id]} not found"
  end

  def assign_latest_id
    @latest_id = Crossword.last.id
  end

  def assign_current_id
    @current_id = @crossword&.id
  end
end
