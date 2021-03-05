Rails.application.routes.draw do
root to: 'homes#top'
get 'homes/about' => "homes#about"
devise_for :users

resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
end

resources :users, only: [:index, :show, :edit, :update]
end
