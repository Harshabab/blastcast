Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'comments/create'

  devise_for :users
  resources :posts do
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
     resources :comments
  end

  root "posts#index"
  get 'posts/index'

  get 'posts/show'

  get 'posts/new' => 'posts#new'

  get 'posts/create'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
