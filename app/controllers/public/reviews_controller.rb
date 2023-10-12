class Public::ReviewsController < ApplicationController

  def index
    @reviews = Review.page(params[:page]).per(10)
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    @recipe = @review.recipe
    review_count = Review.where(recipe_id: params[:recipe_id]).where(user_id: current_user.id).count
    if @review.valid?
      if review_count < 1
        @review.save
        redirect_to reviews_path, notice: "レビューを保存しました"
      else
        redirect_to reviews_path, notice: "レビューの投稿は一度までです"
      end
    else
      flash.now[:alert] = "レビューの保存に失敗しました"
      render :index
    end
  end


  def edit
    @review = Review.find(params[:id])
    if @review.user == current_user
      render "edit"
    else
      redirect_back fallback_location: root_path, flash: { alert: "他人のレビューは編集できません" }
    end
  end

  def update
    @review = Review.find(params[:id])
    @recipe = @review.recipe
    if @review.update(review_params)
      redirect_to reviews_path(review), flash: { notice: "レビューを更新しました。" }
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user == current_user
      @review.destroy
      redirect_to mypage_path, flash: { notice: "レビューを削除しました。" }
    else
      redirect_back fallback_location: root_path, flash: { alert: "他人のレビューは編集できません" }
    end
  end


  private

  def review_params
    params.require(:review).permit(:comment, :star).
    merge(user_id: current_user.id, recipe_id: params[:recipe_id]
    )
  end


end
