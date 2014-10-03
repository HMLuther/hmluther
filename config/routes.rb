Hmluther::Application.routes.draw do

  get 'remote_collection_addition', to: 'remote_content#remote_collection_addition'
  get 'remote_collection_info_request', to: 'remote_content#remote_collection_info_request'
  get 'remote_feedback', to: 'remote_content#remote_feedback'
  get 'remote_info_request', to: 'remote_content#remote_info_request'
  get 'remote_share_item', to: 'remote_content#remote_share_item'
  get 'remote_share_collection', to: 'remote_content#remote_share_collection'
  get 'remote_login', to: 'remote_content#remote_login'
  get 'remote_sign_up', to: 'remote_content#remote_sign_up'
  get 'category/:category', to: 'items#category', as: :category
  get 'set_recently_viewed', to: 'items#set_recently_viewed'
  post 'set_new_item', to: "collections#set_new_item"

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  resources "contacts", only: [:new, :create]
  resources "info_requests", only: [:new, :create]
  resources "feedbacks", only: [:new, :create]
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