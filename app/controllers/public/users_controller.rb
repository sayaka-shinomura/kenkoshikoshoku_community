class Public::UsersController < ApplicationController

  def show
    @user = current_user
  end

  def index
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update (user_params)
    redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
  end

  def check
    @user = current_user
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private


  def user_params
    params.require(:user).permit(:account_name, :email, :telephone_number, :birth_date, :gender)
  end

end
