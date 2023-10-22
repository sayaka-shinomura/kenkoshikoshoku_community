class Public::RequestsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @requests = Request.page(params[:page]).per(10)
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      redirect_to request_path(@request.id), flash: { notice: "ご意見・ご要望を投稿しました。" }
    else
      render :new
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def destroy
    @request = Request.find(params[:id])
    if @request.user == current_user
      @request.destroy
      redirect_to mypage_path, flash: { notice: "ご意見・ご要望の取り消しを実行しました" }
    else
      redirect_back fallback_location: root_path, flash: { alert: "他人のリクエストは削除できません" }
    end
  end


  private


  def request_params
    params.require(:request).permit(:user_id, :content)
  end

end
