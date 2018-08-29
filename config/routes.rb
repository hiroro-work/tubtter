Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users, only: [:show] do
    member do
      get 'followings', 'followers', 'allusers'
      patch 'follow', 'unfollow'
    end
    resources :tweets, only: [:show, :new, :edit, :create, :update, :destroy]
  end

  get 'home/index'
  root 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
