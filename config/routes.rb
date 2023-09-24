Rails.application.routes.draw do

  namespace :public do
    get 'users/show'
    get 'users/index'
    get 'users/edit'
    get 'users/check'
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

namespace :admin do
    get 'top' => 'homes#top', as: 'top'
  end

scope module: :public do
    root 'homes#top'

    get 'customers/mypage' => 'customers#show', as: 'mypage'

  end

end
