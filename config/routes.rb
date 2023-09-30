Rails.application.routes.draw do

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }

  namespace :api do
    namespace :v1 do
      get 'current_user', to: 'current_user#index'
      resources :trades, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
