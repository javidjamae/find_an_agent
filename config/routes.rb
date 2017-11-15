Rails.application.routes.draw do
  
  root to: "home#index"

  resources :agent_searches, only: [:show, :create]
end
