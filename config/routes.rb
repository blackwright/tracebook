Rails.application.routes.draw do
  
  root 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :users, except: [:edit, :update] do
    resource :profile, only: [:show, :edit, :update]
    resources :posts, only: [:create, :destroy]
  end

  resources :likes, only: [:create, :destroy]
end
