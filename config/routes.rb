Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "quick_crosswords#index"

  get "squabble", to: "squabble#index"
  namespace :squabble do
    resources :tables, only: [:index, :show], param: :table_name
  end

  resources :quick,
    only: [:index, :show],
    controller: :quick_crosswords,
    as: :quick_crosswords,
    param: :slug

  match "*unmatched", to: "application#not_found", via: :all
end
