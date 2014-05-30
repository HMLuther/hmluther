Hmluther::Application.routes.draw do
  resources :subcategories

  resources :categories

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end