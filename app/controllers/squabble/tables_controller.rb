module Squabble
  class TablesController < ApplicationController
    include Pagination
    include TablesConcern

    before_action :validate_table_name, only: [:show]
    before_action :assign_model, only: [:show]

    def index
      redirect_to squabble_path
    end

    def show
      @records = @model.all.then(&paginate)
    end

    private

    def validate_table_name
      unless ActiveRecord::Base.connection.table_exists?(params[:table_name])
        raise ActionController::RoutingError, "Table not found"
      end
    end

    def assign_model
      @model = params[:table_name].classify.constantize
    end
  end
end
