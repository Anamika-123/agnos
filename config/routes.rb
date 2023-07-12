# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post "signup", to: "users#create", as: :signup
    post "login", to: "sessions#create", as: :login
    get "logout", to: "sessions#destroy", as: :logout

    get "/cart", to: "orders#show"
    patch "order/complete", to: "orders#placed"

    resources :products, only: %i[index create]
    resources :order_items, only: %i[create update destroy]
    resources :promotions, only: %i[create]
  end
end

