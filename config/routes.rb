Rails.application.routes.draw do
  devise_for :users

  get "/accounts/new", to: "accounts#new", as: :new_account
  post "/accounts", to: "accounts#create", as: :accounts

  scope module: "accounts" do
    resources :projects
    root to: "projects#index"

    namespace :api do
      namespace :v1 do
        resources :projects
      end
    end

    resources :invitations, only: [:new, :create] do
      member do
        get :accept
        patch :accepted
      end
    end
  end

end
