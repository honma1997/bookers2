Rails.application.routes.draw do
  resources :books

  devise_for :users

  resources :users

  resources :post_images, only: [:new, :index, :show]

  root to: "homes#top"

  get 'homes/about', to: 'homes#about', as: :about
end
