Rails.application.routes.draw do
  devise_for :users

  get 'home/index'
  root to: "accounts#index"

  get "/accounts/new", to: "accounts#new", as: :new_account
  post "/accounts", to: "accounts#create", as: :accounts

  namespace :api do
    namespace :v1 do
      resources :projects
    end
  end

  resources :accounts do
    resources :invitations, only: [:new, :create] do
      member do
        get :accept
        patch :accepted
      end
    end

    resources :projects

    resources :users, only: [:index, :destroy]
  end
end
