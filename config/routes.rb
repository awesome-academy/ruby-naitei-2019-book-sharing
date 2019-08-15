Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  concern :paginatable do
        get "(page/:page)", action: :index, on: :collection, as: ""
  end
  resources :users do
    member do
      get "followers/new", to: "followers#new"
      get "following/new", to: "following#new"
    end
  end
  resources :books, only: %i(index show) do
    resources :rates, only: [:create]
  end
  resources :genres, only: :show
  resources :posts do
    resources :comments
    resources :likes, only: %i(create destroy)
  end
  resources :relationships, only: %i(create destroy)
  resources :messages, only: :index
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: :create
  end

  mount ActionCable.server, at: '/cable'
end
