Rails.application.routes.draw do
  devise_for :users
  resources :users
  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  root 'hello#index' 
end
