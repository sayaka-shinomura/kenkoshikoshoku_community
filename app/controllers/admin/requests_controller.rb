class Admin::RequestsController < ApplicationController

  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :edit, :update]


  def index
    @requests = Request.page(params[:page]).per(15)
  end

  def show
    @request = Request.find(params[:id])
    @requests = Request.all
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
     @request = Request.find(params[:id])
    if @request.update(request_params)
      redirect_to admin_request_path(@request.id)
    else
      render :edit
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "削除を実行しました"
    redirect_to admin_requests_path
  end

  private

  def effect_params
    params.require(:request).permit(:user_id, :content, :confirm)
  end

  def ensure_user
    @user = User.find(params[:id])
  end


end
