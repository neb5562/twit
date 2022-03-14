Rails.application.routes.draw do
  resources :likes
  resources :notifications
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :tweets, except: [:edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "tweets#index"
  get "users/:name", to: "users#profile", as: 'show_user_profile'
  
end
