Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#show"


  resources :quick, only: [:index, :show], module: :crosswords, as: :quick_crosswords
end
