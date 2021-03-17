Rails.application.routes.draw do
# mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
root to: 'homes#top'
get 'homes/about' => "homes#about"
devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :passwords => 'users/passwords'
   }
devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#new_guest'
end
resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
end

resources :users, only: [:index, :show, :create, :edit, :update] do
   get "users/follower" => "users#follower"
   get "users/followed" => "users#followed"
end

# resources :users do
#     get "users/follower" => "users#follower"
#     get "users/followed" => "users#followed"
# end
post 'follow/:id' => 'relationships#follow', as: 'follow'
delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

resources :inquiries, only: [:new, :create]
end
