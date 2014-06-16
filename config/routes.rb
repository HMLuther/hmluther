Hmluther::Application.routes.draw do

  resources :designers

  get 'category/:category', to: 'items#category', as: :category
  get 'maker/:maker', to: 'items#maker', as: :maker

  resources :images

  resources :items

  # resources :subcategories

  # resources :categories

  get 'contact', to: 'contact#index'
  get 'features', to: 'features#index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users
  
  resources :collections

end