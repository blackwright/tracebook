Rails.application.routes.draw do

  root 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :users, except: [:edit, :update] do
    get 'newsfeed' => 'users#newsfeed'
    get 'friends' => 'friendings#index'
    resource :profile, only: [:show, :edit, :update]
    resources :posts, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy],
                           :defaults => { commentable: "Post" }
    end
    post 'photos/link' => 'photos#link', as: 'photo_link'
    resources :photos, except: [:edit, :update] do
      post 'avatar' => 'profiles#set_avatar', as: 'avatar'
      post 'cover' => 'profiles#set_cover', as: 'cover'
      resources :comments, only: [:create, :destroy],
                           :defaults => { commentable: "Photo" }
    end
  end

  resources :likes, only: [:create, :destroy]
  resources :friendings, only: [:create, :update, :destroy]
end
