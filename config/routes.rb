Rails.application.routes.draw do
  resource :home, only: [:index]

  root to: "home#index"
end
