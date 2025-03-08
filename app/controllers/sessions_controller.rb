class SessionsController < ApplicationController
  rate_limit to: 3, within: 1.minute, only: [:create]

  before_action :ensure_devmode
  before_action :redirect_if_logged_in, only: [:new, :create]

  layout "page"

  def new
    @account = Account.new
  end

  def create
    account = Account.find_by!(key: account_params[:key].downcase)
    session[:current_account_id] = account.id

    redirect_to account_path, notice: "Logged in successfully"
  rescue ActiveRecord::RecordNotFound
    @account = Account.new
    @account.errors.add(:base, "Account not found")
    render :new, status: :unprocessable_entity
  end

  def destroy
    session.delete(:current_account_id)
    Current.account = nil

    redirect_to new_session_path, notice: "Logged out successfully", status: :see_other
  end

  private

  def account_params
    params.require(:account).permit(:key)
  end
end
