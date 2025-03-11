class ApplicationController < ActionController::Base
  before_action :import_latest
  before_action :load_account
  before_action :set_challenge

  helper_method :syncing?
  helper_method :not_syncing?
  helper_method :devmode?

  rescue_from ActionController::RoutingError do
    not_found
  end

  def not_found
    render "application/not_found", status: :not_found
  end

  private

  def syncing? = Current.account.present?

  def not_syncing? = !syncing?

  def devmode? = session[:devmode] == true

  def import_latest
    @last_import ||= Import.latest

    if @last_import
      last_import_hours_ago = ((Time.zone.now - @last_import.created_at.to_time) / 1.hour).floor
      return if last_import_hours_ago <= 24
    end

    @last_import = nil
    ImportLatestGuardianQuickCrosswordsJob.perform_now
  end

  def ensure_devmode
    redirect_to root_path unless devmode?
  end

  def redirect_if_syncing(path = root_path)
    redirect_to path if syncing?
  end

  def redirect_if_not_syncing(path = root_path)
    redirect_to path if not_syncing?
  end

  def current_account
    Current.account
  end

  def current_account=(id)
    cookies.permanent.encrypted[:current_account_id] = id
    load_account
  end

  def load_account
    Current.account = Account.find(cookies.encrypted[:current_account_id]) if cookies.encrypted[:current_account_id]
  end

  def set_challenge
    if not_syncing?
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
