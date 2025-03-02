Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "crosswords#index"

  get ":style", to: "crosswords#index", constraints: {style: /quick/}, as: :crosswords
  get ":style/:slug", to: "crosswords#show", constraints: {style: /quick/}, as: :crossword

  match "*unmatched", to: "application#not_found", via: :all
end
