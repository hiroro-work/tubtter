Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users do
    member do
      get 'folloings'
      get 'followers'
      get 'allusers'
    end
    resources :tweets
  end

  get 'home/index'
  root 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
