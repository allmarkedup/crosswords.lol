Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "crosswords#index"

  get ":style", to: "crosswords#index", constraints: {style: /quick/}, as: :crosswords
  get ":style/:number", to: "crosswords#show", constraints: {number: /\d.+/, style: /quick/}, as: :crossword
end
