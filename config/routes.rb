Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "crosswords#index"

  get ":style", to: "crosswords#index", constraints: {style: /quick/}, as: :crosswords
  get ":style/:id", to: "crosswords#show", constraints: {style: /quick/}, as: :crossword
end
