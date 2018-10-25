Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "books#top"
  get "/about" => "books#about"

  resources :books, only: [:index, :create, :edit, :update, :destroy, :show]
  resources :users, only: [:index, :create, :edit, :update, :show]
end
