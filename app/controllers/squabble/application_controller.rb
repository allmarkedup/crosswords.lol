module Squabble
  class ApplicationController < ActionController::Base
    http_basic_authenticate_with(
      name: Rails.application.credentials.dig(:squabble, :username),
      password: Rails.application.credentials.dig(:squabble, :password)
    )
  end
end
