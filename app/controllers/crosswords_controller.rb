class CrosswordsController < ApplicationController
  before_action :assign_style
  before_action :assign_number
  before_action :assign_latest_number
  before_action :assign_crossword, only: [:show]

  def index
    redirect_to crossword_path(@style, @latest_number)
  end

  def show
    @next_number = @number + 1 unless @number == @latest_number
    @previous_number = @number - 1
  end

  private

  def assign_style
    @style = params[:style]
  end

  def assign_number
    @number = params[:number].to_i
  end

  def assign_crossword
    @crossword = Crossword.find_by!(number: @number)
  rescue ActiveRecord::RecordNotFound
    data = CrosswordScraper.fetch(@style, @number)
    @crossword = Crossword.create(number: @number, style: @style, data:)
  end

  def assign_latest_number
    cookie_name = :"#{@style}_latest_number"
    if cookies[cookie_name]
      @latest_number = cookies[cookie_name].to_i
    else
      @latest_number = CrosswordScraper.latest_number(@style)
      cookies[cookie_name] = {value: @latest_number, expires: Date.current.end_of_day}
    end
  end
end
