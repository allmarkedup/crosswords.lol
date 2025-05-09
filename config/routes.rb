Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "crosswords#index"

  get "/:number", to: "crosswords#show", as: :crossword, constraints: {number: /\d.+/}

  get "/about", to: "pages#about", as: :about_page
  get "/settings", to: "pages#settings", as: :settings_page

  resource "sync", only: [:new, :create, :show], controller: :sync, as: :sync do
    resource :device, only: [:create, :destroy], controller: "sync/device", as: :device
  end
  get "/sync/device", to: "sync/device#new", as: :new_sync_device

  resources :answers, only: [:update]

  mount MissionControl::Jobs::Engine, at: "/jobs"

  namespace :admin do
    resources :crosswords
    resources :answers
    resources :accounts
    resources :imports

    root to: "crosswords#index"
  end

  resource :devmode, only: [:show, :destroy], controller: :devmode

  match "*unmatched", to: "application#not_found", via: :all
end
