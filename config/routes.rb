Rails.application.routes.draw do
  
  root 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :users, except: [:edit, :update] do
    get 'friends' => 'friendings#index'
    resource :profile, only: [:show, :edit, :update]
    resources :posts, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy],
                           :defaults => { commentable: "Post" }
    end
  end

  resources :likes, only: [:create, :destroy]
  resources :friendings, only: [:create, :destroy]
end
