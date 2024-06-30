Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  
  root to: "homes#top"

  resources :posts
  resources :users, only: [:show, :edit, :update, :destroy] do
    collection do #collectionだとidが不要
      get :mypage
    end
  end

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :destroy] do
      resources :comments, controller: :user_comments
    end

    resources :comments
  end
end
