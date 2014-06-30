Hmluther::Application.routes.draw do

  resources :designers

  match 'remote_sign_up', to: 'remote_content#remote_sign_up', via: [:get]
  match 'remote_login', to: 'remote_content#remote_login', via: [:get]
  get 'category/:category', to: 'items#category', as: :category
  get 'maker/:maker', to: 'items#maker', as: :maker

  resources :images

  resources :items

  get 'contact', to: 'contact#index'
  get 'features', to: 'features#index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  resources :users
  
  resources :collections do
    get 'carousel', on: :member
    get 'slideshow', on: :member
    resources :collection_items
  end

end