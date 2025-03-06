class ApplicationController < ActionController::Base
  before_action :set_account
  before_action :set_challenge

  helper_method :logged_in?
  helper_method :logged_out?
  helper_method :devmode?

  rescue_from ActionController::RoutingError do
    not_found
  end

  def not_found
    render "application/not_found", status: :not_found
  end

  private

  def logged_in? = Current.account.present?

  def logged_out? = !logged_in?

  def devmode? = session[:devmode] == true

  def ensure_devmode
    redirect_to root_path unless devmode?
  end

  def redirect_if_logged_in(path = root_path)
    redirect_to path if logged_in?
  end

  def redirect_if_logged_out(path = root_path)
    redirect_to path if logged_out?
  end

  def set_account
    Current.account = Account.find(session[:current_account_id]) if session[:current_account_id]
  end

  def set_challenge
    if logged_out?
      if cookies[:account_challenge].present?
        Current.challenge = AccountChallenge.from_cookie(cookies[:account_challenge])
      else
        Current.challenge = AccountChallenge.new
        cookies[:account_challenge] = Current.challenge.to_cookie_value
      end
    else
      Current.challenge = nil
      cookies[:account_challenge] = nil
    end
  end
end
