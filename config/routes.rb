Rails.application.routes.draw do
  devise_for :users

  root to: "projects#index"

  get "/accounts/new", to: "accounts#new", as: :new_account
  post "/accounts", to: "accounts#create", as: :accounts

  namespace :api do
    namespace :v1 do
      resources :projects
    end
  end

  resources :projects
end
