# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users,
             module: :auth,
             path: '/auth',
             path_names: {
               sign_in: 'sessions',
               registration: 'registrations',
               password: 'passwords'
             }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # routes
      namespace :customer do
        resources :products, only: %i[index show]
        resources :favorites, only: %i[index create destroy]
        resources :cart_items, only: %i[index update destroy], path: '/cart'
        resources :invoices, only: %i[index create]
        resource :users, only: %i[show update], path: '/profile'
      end

      namespace :provider do
        resources :products, only: %i[index show update create destroy]
        resources :categories, only: %i[index create]
        resource :users, only: %i[show update], path: '/profile'
      end

      # Should be implemented later
      # namespace :admin do
      #   resources :products
      #   resources :categories
      # end
    end
  end
end
