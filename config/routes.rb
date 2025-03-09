Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "quick_crosswords#index"

  resource :sync, only: [:new, :create, :show], controller: :sync do
    resource :device, only: [:create, :destroy], controller: "sync/device"
  end
  get "/sync/device", to: "sync/device#new", as: :new_sync_device

  resource :devmode, only: [:show, :destroy], controller: :devmode

  resources :quick,
    only: [:index, :show],
    controller: :quick_crosswords,
    as: :quick_crosswords,
    param: :slug

  resources :answers, only: [:update]

  match "*unmatched", to: "application#not_found", via: :all
end
