module Crosswords
  class QuickController < ApplicationController
    before_action :assign_number
    before_action :assign_latest_number
    before_action :assign_crossword, only: [:show]

    def index
      redirect_to quick_crossword_path(id: @latest_number)
    end

    def show
      @next_number = @number + 1 unless @number == @latest_number
      @previous_number = @number - 1
    end

    private

    def assign_number
      @number = params[:id].to_i
    end

    def assign_crossword
      @crossword = Crossword.find_by!(number: @number)
    rescue ActiveRecord::RecordNotFound
      data = Providers::Guardian.fetch(:quick, @number)
      @crossword = Crossword.create(number: @number, style: "quick", data:)
    end

    def assign_latest_number
      if cookies[:quick_latest_number]
        @latest_number = cookies[:quick_latest_number].to_i
      else
        @latest_number = Providers::Guardian.latest_number(:quick)
        cookies[:quick_latest_number] = {value: @latest_number, expires: Date.current.end_of_day}
      end
    end
  end
end
