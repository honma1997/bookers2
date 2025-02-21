Rails.application.routes.draw do
  resources :books

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :post_images

  root to: "home#top"

  get 'home/about', to: 'home#about', as: :about
end
