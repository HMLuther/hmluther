Hmluther::Application.routes.draw do

  get 'remote_info_request', to: 'remote_content#remote_info_request'
  get 'remote_share_item', to: 'remote_content#remote_share_item'
  get 'remote_share_collection', to: 'remote_content#remote_share_collection'
  get 'remote_login', to: 'remote_content#remote_login'
  get 'remote_sign_up', to: 'remote_content#remote_sign_up'
  get 'category/:category', to: 'items#category', as: :category

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  resources "contacts", only: [:new, :create]
  resources "info_requests", only: [:new, :create]
  resources "shares", only: [:new, :create]
  resources :designers
  resources :images
  resources :items
  resources :pages
  resources :users
  
  resources :collections do
    get 'slideshow', on: :member
    resources :collection_items
  end

  root :to => "home#index"

end