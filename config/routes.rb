Rails.application.routes.draw do

  namespace :public do
    get 'want_to_make_lists/index'
  end
# ゲストログイン用
devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in', as: 'user_guest_sign_in'
    get 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

# ユーザー用
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


# 管理者用
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}


scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'

    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/check' => 'users#check', as: 'check_user'
    put 'users/information' => 'users#update'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
    get 'users/myrecipe' => 'users#index', as: 'myrecipe'

    resources :recipes, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :vegetables, only: [:index, :show]
    resources :nutrients, only: [:index, :show]
    resources :effects, only: [:index, :show]

end


namespace :admin do
    get 'top' => 'homes#top', as: 'top'

    resources :users, only: [:index, :show, :edit, :update]
    resources :vegetables, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :nutrients, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :effects, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  end

end
