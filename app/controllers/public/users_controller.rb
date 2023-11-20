class Public::UsersController < ApplicationController

  def show
    @user = current_user
    @recipes = @user.recipes

    want_to_make_lists = WantToMakeList.where(user_id: current_user.id).pluck(:recipe_id)
    @want_list = Recipe.find(want_to_make_lists).first(3).order(created_at: :desc)

    made_lists = MadeList.where(user_id: current_user.id).pluck(:recipe_id)
    @made_list = Recipe.find(made_lists).first(3).order(created_at: :desc)
  end

  def index
    @myrecipes = Recipe.where(user_id: current_user.id).includes(:user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update (user_params)
    redirect_to mypage_path, notice: 'ユーザー情報を更新しました。'
  end

  def check
    @user = current_user
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を行いました。ご利用ありがとうございました。"
    redirect_to root_path
  end


  private


  def user_params
    params.require(:user).permit(:account_name, :email, :telephone_number, :birth_date, :gender)
  end

end
