Hmluther::Application.routes.draw do

  get 'category/:tag', to: 'items#tags', as: :tag

  resources :images

  resources :items

  resources :subcategories

  resources :categories

  get 'contact', to: 'contact#index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end