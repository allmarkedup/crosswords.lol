module Crosswords
  class QuickController < ApplicationController
    before_action :assign_latest_id

    def index
    end

    def show
      data = Providers::Guardian.fetch(:quick, params[:id])
      @crossword = ::Crossword.new(data)

      @current_id = params[:id].to_i
      @next_id = @current_id == @latest_id ? nil : @current_id + 1;
      @previous_id = @current_id - 1;
    end

    private

    def assign_latest_id
      @latest_id = Providers::Guardian.latest_id(:quick)
    end
  end
end
