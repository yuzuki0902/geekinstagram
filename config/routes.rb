Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :maps, only: [:index]
  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  root to: 'maps#index'
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

end
