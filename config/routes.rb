# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  get "users", to: "users#index"
  get "users/:id", to: "users#show", as: "user_show"
  get "users/:user_id/posts", to: "posts#index", as: "user_post"
  get "users/:user_id/posts/new", to: "posts#new", as: "user_posts_new"
  get "users/:user_id/posts/:id", to: "posts#show", as: "user_post_details"
  post "users/:user_id/posts/create", to: "posts#create", as: "user_posts"
  get "users/:user_id/posts/:id/comments/new", to: "comments#new", as: "user_comment_new"
  post "users/:user_id/posts/:id/comments/create", to: "comments#create", as: "create_comment"
  post "users/:user_id/posts/:id/likes/create", to: "likes#create", as: "user_post_likes_create"

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index] do
      resources :posts, only: [:show] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
