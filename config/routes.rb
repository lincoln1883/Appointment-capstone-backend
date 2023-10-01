Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create]
      resources :trades, only: [:index, :create, :show, :update, :destroy]
      resources :reservations, only: [:index, :create, :show, :destroy]
    end
  end
end
