Rails.application.routes.draw do
  # ゲストログイン用
  devise_scope :user do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in", as: "user_guest_sign_in"
    get "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # ユーザーログイン用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者ログイン用
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  # 検索用
  get "search" => "searches#search"


  # ユーザー利用時
  scope module: :public do
    root "homes#top"
    get "homes/about" => "homes#about", as: "about"

    get "users/mypage" => "users#show", as: "mypage"
    get "users/information/edit" => "users#edit", as: "edit_information"
    patch "users/information" => "users#update", as: "update_information"
    get "users/check" => "users#check", as: "check_user"
    put "users/information" => "users#update"
    patch "users/withdraw" => "users#withdraw", as: "withdraw_user"
    get "users/myrecipe" => "users#index", as: "myrecipe"


    get "recipes/search" => "recipes#search", as: "search_recipes"
    get "vegetables/search" => "vegetables#search", as: "search_vegetables"
    get "res/search" => "requests#search", as: "search_requests"

    resources :recipes do
      resources :want_to_make_lists, only: [:index, :create, :destroy]
      resources :made_lists, only: [:index, :create, :destroy]
      resources :reviews, only: [:create]
      get :want_to_make_lists, on: :collection
      get :made_lists, on: :collection
    end

    resources :vegetables, only: [:index, :show]
    resources :nutrients, only: [:index, :show]
    resources :effects, only: [:index, :show]
    resources :reviews, only: [:index, :new, :create, :edit, :destroy, :update]
    get "reviews/search" => "reviews#search", as: "search_reviews"
    resources :requests, only: [:index, :new, :create, :show, :destroy]
  end


  # 管理者使用時
  namespace :admin do
      get "top" => "homes#top", as: "top"

      resources :users, only: [:index, :show, :edit, :update]
      resources :vegetables, only: [:index, :new, :create, :show, :edit, :update, :destroy]
      resources :nutrients, only: [:index, :new, :create, :show, :edit, :update, :destroy]
      resources :effects, only: [:index, :new, :create, :show, :edit, :update, :destroy]
      resources :reviews, only: [:index, :show, :destroy]
      resources :requests, only: [:index, :show, :edit, :update, :destroy]
    end
end
