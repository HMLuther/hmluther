Hmluther::Application.routes.draw do

  get 'category/:category', to: 'items#category', as: :category
  get 'maker/:maker', to: 'items#maker', as: :maker

  resources :images

  resources :items

  # resources :subcategories

  # resources :categories

  get 'contact', to: 'contact#index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end