Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create]
      resources :trades, only: [:index, :create, :show, :update, :destroy]
      resources :reservations, only: [:index, :create, :show, :destroy]
    end
  end
end
