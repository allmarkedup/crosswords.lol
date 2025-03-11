Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "quick_crosswords#index"

  get "/about", to: "pages#about", as: :about_page

  resource :sync, only: [:new, :create, :show], controller: :sync do
    resource :device, only: [:create, :destroy], controller: "sync/device"
  end
  get "/sync/device", to: "sync/device#new", as: :new_sync_device

  resources :quick,
    only: [:index, :show],
    controller: :quick_crosswords,
    as: :quick_crosswords,
    param: :slug

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
