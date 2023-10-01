class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :edit, :update]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params) ? (redirect_to admin_user_path(@user)) : (render :edit)
  end


  private


  def user_params
    params.require(:user).permit(
      :account_name,
      :email,
      :telephone_number,
      :birth_date,
      :gender,
      :is_active)
  end

  def ensure_user
    @user = User.find(params[:id])
  end

end
