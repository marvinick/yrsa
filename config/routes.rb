  Rails.application.routes.draw do
  get 'activities/index'

  devise_for :users

  get "/home", to: "home#home", as: :home

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
    get "/billing",
      to: "billings#payment_details",
      as: :billing
    put "/billing/update_details",
      to: "billings#update_payment_details",
      as: :update_payment_details

    resources :projects do
      resources :items do
        resources :details do
          resources :reviews
        end
      end
      resources :boards
    end

    resources :invitations do
      member do
        get :accept
        patch :accepted
      end
    end

    resources :users, only: [:index, :destroy]
  end

  namespace :admin do
    root to: "members#index"

    resources :members, only: [:index, :show] do
      collection do
        post :search
        get :unpaid
      end
    end
  end

  post "/stripe/webhook", to: "stripe_webhooks#receive"

  resources :activities
end
