# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'
  resources :transactions
  resources :users
  get '/rewards' => 'users_rewards#index', as: 'rewards'
  root 'transactions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
