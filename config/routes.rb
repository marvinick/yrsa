Rails.application.routes.draw do

  devise_for :users

  get "/home", to: "home#home", as: :home

  root to: "accounts#index"

  get "/accounts/new", to: "accounts#new", as: :new_account
  post "/accounts", to: "accounts#create", as: :accounts

  resources :accounts, :except => [:show] do
    get 'activities/index'

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
      resources :users, only: [:index, :destroy, :new, :create] do
        member do
          delete 'unfollow'
        end
      end

      resources :details

      resources :items do
        resources :reviews
        resources :details
      end

      resources :boards

      resources :invitations do
        member do
          get :accept
          patch :accepted
        end
      end
    end

  end

  resources :lookups

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

  resources :notifications, only: [:index] do
    post :mark_as_read, on: :collection
    post :mark_as_read, on: :member
  end
end
