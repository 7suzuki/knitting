Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: "admin_users/sessions"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  root to: "homes#top"

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy] do
    collection do #collectionだとidが不要
      get :mypage
    end
  end
  get "/search", to: "posts#search"

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :destroy] do
      resources :comments, controller: :user_comments
    end

    resources :comments
  end
end
