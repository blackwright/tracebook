Rails.application.routes.draw do
  
  root 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :users, except: [:edit, :update]
end
