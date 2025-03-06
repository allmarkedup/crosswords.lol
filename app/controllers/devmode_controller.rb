class DevmodeController < ApplicationController
  http_basic_authenticate_with(
    name: Rails.application.credentials.devmode.http_basic_auth_user,
    password: Rails.application.credentials.devmode.http_basic_auth_password,
    only: :show
  )

  def show
    session[:devmode] = true
    redirect_to root_path
  end

  def destroy
    session[:devmode] = false
    redirect_to root_path, status: :see_other
  end
end
