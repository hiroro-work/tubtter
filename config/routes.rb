Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: %i[index show] do
    resources :tweets, only: %i[show new edit create update destroy]
    resources :replies, only: %i[index show destroy], module: :users
    resources :retweets, only: %i[index show destroy], module: :users
    resources :followers, only: %i[index]
    resource  :follower, only: %i[create destroy]
    resources :followings, only: %i[index]
    resources :unfollowings, only: %i[index]
  end

  resources :tweets do
    resources :replies, only: %i[new edit create update], module: :tweets
    resources :retweets, only: %i[new edit create update], module: :tweets
  end

  get 'home/index'
  root 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
