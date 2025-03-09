class AnswersController < ApplicationController
  before_action :redirect_if_logged_out

  def update
    @answer = Current.account.answers.find(params[:id])
    @answer.update(permitted_params)

    AnswersChannel.broadcast_to(@answer, {initiator_id: params[:client_id], answer: @answer})

    respond_to do |format|
      format.html do
        redirect_to quick_crossword_path(@answer.crossword), status: :see_other
      end
      format.json do
        render json: @answer
      end
    end
  end

  private

  def permitted_params
    params[:answer].permit!
  end
end
