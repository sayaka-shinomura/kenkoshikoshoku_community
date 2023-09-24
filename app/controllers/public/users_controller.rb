class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def index
  end

  def edit
  end

  def update
    if @user.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def check
  end

  def withdraw
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_user
    @user = current_user
  end

  def cuser_params
    params.require(:user).permit(:account_name, :email, :telephone_number, :birth_date, :gender)
  end

end
