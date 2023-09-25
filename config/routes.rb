Rails.application.routes.draw do

  namespace :admin do
    get 'effects/index'
    get 'effects/new'
    get 'effects/show'
    get 'effects/edit'
  end
  namespace :admin do
    get 'nutrients/index'
    get 'nutrients/new'
    get 'nutrients/show'
    get 'nutrients/edit'
  end
  namespace :admin do
    get 'vegetables/index'
    get 'vegetables/new'
    get 'vegetables/show'
    get 'vegetables/edit'
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

    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/check' => 'users#check', as: 'check_user'
    put 'users/information' => 'users#update'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'

end


namespace :admin do
    get 'top' => 'homes#top', as: 'top'
  end

end
