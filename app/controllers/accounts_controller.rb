class AccountsController < ApplicationController
  before_action :ensure_devmode
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action -> { redirect_if_logged_out(new_session_path) }, only: [:show]

  layout "page"

  def new
    @account = Account.new
  end

  def create
    if Current.challenge.validate(challenge_params[:challenge_solution])
      @account = Account.create
      session[:current_account_id] = @account.id

      redirect_to account_path, notice: "Account created"
    else
      @account = Account.new
      @account.errors.add(:base, "Incorrect solution. Try again?")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @account = Current.account
  end

  private

  def challenge_params
    params.require(:account).permit(:challenge_solution)
  end
end
