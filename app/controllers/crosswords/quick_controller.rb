module Crosswords
  class QuickController < ApplicationController
    def index
    end

    def show
      data = Scrapers::Guardian.fetch(:quick, params[:id])
      @crossword = ::Crossword.new(data)
    end
  end
end
