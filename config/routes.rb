Rails.application.routes.draw do
  resources :retweets
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show] do
    member do
      get :followings, :followers, :allusers
      patch :follow, :unfollow
    end
    resources :tweets, only: %i[show new edit create update destroy]
    resources :replies, only: %i[index show edit update destroy]
  end

  resources :tweets do
    resources :replies, only: %i[new create]
  end

  get 'home/index'
  root 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
