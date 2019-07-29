Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  concern :paginatable do
        get "(page/:page)", action: :index, on: :collection, as: ""
  end
  resources :users
  resources :books, only: %i(index show) do
    resources :rates, only: [:create]
  end
  resources :genres, only: :show
  resources :posts do
    resources :comments
    resources :likes, only: %i(create destroy)
  end
end
