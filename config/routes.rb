Hmluther::Application.routes.draw do

  resources :designers

  get 'category/:category', to: 'items#category', as: :category
  get 'maker/:maker', to: 'items#maker', as: :maker

  resources :images

  resources :items

  get 'contact', to: 'contact#index'
  get 'features', to: 'features#index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users
  
  resources :collections do
    get 'carousel', on: :member
    get 'slideshow', on: :member
    resources :collection_items
  end

end