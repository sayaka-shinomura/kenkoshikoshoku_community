class Admin::ReviewsController < ApplicationController

  def index
    @reviews = Review.page(params[:page]).per(10).all.order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "削除を実行しました"
    redirect_to admin_reviews_path
  end

end
