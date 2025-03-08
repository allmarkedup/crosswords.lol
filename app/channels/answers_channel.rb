class AnswersChannel < ApplicationCable::Channel
  def subscribed
    answer = current_account.answers.find(params[:id])
    stream_for answer
  end
end
