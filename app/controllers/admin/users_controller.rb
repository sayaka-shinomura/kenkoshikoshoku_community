class Admin::UsersController < ApplicationController
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

end
