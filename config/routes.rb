Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: "admin_users/sessions"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  

  scope module: :public do
    root to: "homes#top"
    resources :posts do
      resource :like, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update, :destroy, :like] do
      collection do #collectionだとidが不要
        get :mypage
      end
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      
      get "like", to: "users#like", as: "like"
    end
    get "/search", to: "posts#index"
  end
  
  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:index, :destroy]
    end
    resources :users, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:index, :destroy]
    end
    resources :post_comments, only: [:index, :destroy]
  end
end
