class CrosswordsController < ApplicationController
  before_action :assign_latest
  before_action :assign_crossword, only: [:show]
  before_action :assign_related, only: [:show]

  def index
    redirect_to crossword_path(@latest)
  end

  def show
    if Current.account
      @answer = Current.account.answers.find_or_create_by(crossword_id: @crossword.id)
    end
  end

  private

  def assign_crossword
    @crossword = Crossword.find_by!(number: params[:number]).decorate
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new "Crossword `#{params[:number]}` not found"
  end

  def assign_latest
    @latest = Crossword.latest
  end

  def assign_related
    @next = @crossword.next || @crossword
    @previous = @crossword.previous || @crossword
    @random = Crossword.random
  end
end
