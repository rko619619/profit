# frozen_string_literal: true

Rails.application.routes.draw do
  root 'books#index'
  get 'searches', to: 'searches#index', as: :search
  resources :books
  resources :categories, only: :index
end
