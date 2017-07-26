Rails.application.routes.draw do
  devise_for :users

  post "/accounts", to: "accounts#create", as: :accounts
  
  namespace :api do
    namespace :v1 do
      resources :projects
    end
  end

  resources :projects
end
