Rails.application.routes.draw do
  devise_for :users
  resources :users
  get 'home/index'

  # authenticated :user do
  #   root to: 'users#show', as: :user_root
  # end
  root 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
