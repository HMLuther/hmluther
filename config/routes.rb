Hmluther::Application.routes.draw do
  resources :images

  resources :items

  resources :subcategories

  resources :categories

  get 'contact', to: 'contact#index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end