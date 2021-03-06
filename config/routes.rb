Rails.application.routes.draw do
root to: 'homes#top'
get 'homes/about' => "homes#about"
devise_for :users

resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
end

resources :users, only: [:index, :show, :edit, :update] do
   get "users/follower" => "users#follower"
   get "users/followed" => "users#followed"
end
  
# resources :users do
#     get "users/follower" => "users#follower"
#     get "users/followed" => "users#followed"
# end
post 'follow/:id' => 'relationships#follow', as: 'follow'
delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

end
