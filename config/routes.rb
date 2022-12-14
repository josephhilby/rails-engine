# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'item_find#show'
      get '/items/find_all', to: 'item_find#index'

      get '/merchants/find', to: 'merchant_find#show'
      get '/merchants/find_all', to: 'merchant_find#index'
      resources :merchants, only: %i[index show] do
        resources :items, controller: :merchant_items, only: [:index]
      end
      resources :items
      get '/items/:id/merchant', to: 'item_merchants#show'
    end
  end
end
