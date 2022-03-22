Rails.application.routes.draw do
  resources :notifications
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :tweets, except: [:edit] do
    resources :likes,except: [:edit, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "tweets#index"
  get "users/:name", to: "users#profile", as: 'show_user_profile'
  post "follow", to: "users#follow", as: "follow_user"
  delete "follow", to: "users#unfollow", as: "unfollow_user"
  get "retweet/:id", to: "tweets#retweet", as: "retweet_tweet"
  get "search/:where", to: "application#search", as: "search"
end
