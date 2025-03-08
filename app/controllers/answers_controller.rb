class AnswersController < ApplicationController
  before_action :redirect_if_logged_out

  def update
    @answer = Current.account.answers.find(params[:id])
    @answer.update(values: JSON.parse(permitted_params[:values]))

    respond_to do |format|
      format.html do
        redirect_to quick_crossword_path(@answer.crossword)
      end
      format.json do
        render json: @answer
      end
    end
  end

  private

  def permitted_params
    params.require(:answer).permit(:values)
  end
end
