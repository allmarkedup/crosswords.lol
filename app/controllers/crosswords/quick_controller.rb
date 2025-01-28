module Crosswords
  class QuickController < ApplicationController
    before_action :assign_latest_id

    def index
      redirect_to quick_crossword_path(id: @latest_id)
    end

    def show
      data = Providers::Guardian.fetch(:quick, params[:id])
      @crossword = ::Crossword.new(data)

      @current_id = params[:id].to_i
      @next_id = @current_id + 1 unless @current_id == @latest_id;
      @previous_id = @current_id - 1;
    end

    private

    def assign_latest_id
      if cookies[:quick_latest_id]
        @latest_id = cookies[:quick_latest_id].to_i
      else
        @latest_id = Providers::Guardian.latest_id(:quick)
        cookies[:quick_latest_id] = { value: @latest_id, expires: Date.current.end_of_day }
      end
    end
  end
end
