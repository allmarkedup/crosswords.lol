Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "quick_crosswords#index"

  resource :account, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :quick,
    only: [:index, :show],
    controller: :quick_crosswords,
    as: :quick_crosswords,
    param: :slug

  get "debug", to: "debug#index", as: :debug

  match "*unmatched", to: "application#not_found", via: :all
end
