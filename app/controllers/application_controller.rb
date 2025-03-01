class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError do
    not_found
  end

  def not_found
    render "application/not_found", status: :not_found
  end
end
