Rails.application.routes.draw do
  devise_for :users

  get 'home/index'
  root to: "accounts#index"

  get "/accounts/new", to: "accounts#new", as: :new_account
  post "/accounts", to: "accounts#create", as: :accounts

  resources :accounts do
    get "/choose_plan",
      to: "plans#choose",
      as: :choose_plan
    patch "/choose_plan",
      to: "plans#chosen"
    delete "/cancel",
      to: "plans#cancel",
      as: :cancel_subscription
    put "/switch_plan",
      to: "plans#switch",
      as: :switch_plan
      
    resources :projects

    resources :invitations do
      member do
        get :accept
        patch :accepted
      end
    end

    resources :users, only: [:index, :destroy]
  end
end
