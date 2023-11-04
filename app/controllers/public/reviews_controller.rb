class Public::ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    @reviews = Review.page(params[:page]).per(10).all.order(created_at: :desc)

  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new
    @recipe.reviews.build
  end

  def create
    @review = current_user.reviews.new(review_params)
    @recipe = @review.recipe
    review_count = Review.where(recipe_id: params[:recipe_id]).where(user_id: current_user.id).count
    if @review.valid?
      if review_count < 1
        @review.save
        redirect_to reviews_path, notice: "レビューを投稿しました。"
      else
        redirect_to reviews_path, notice: "レビューの投稿は一度までです。レビュー内容を変更したい場合は、レビューの編集を行って下さい。"
      end
    else
      flash.now[:notice] = "レビューの保存に失敗しました"
      render :index
    end
  end

  def edit
    @review = Review.find(params[:id])
    if @review.user == current_user
      render "edit"
    else
      redirect_back fallback_location: root_path, flash: { notice: "他人のレビューは編集できません" }
    end
  end

  def update
    @review = Review.find(params[:recipe_id])
    @recipe = @review.recipe

    if @review.update(review_params)
      redirect_to reviews_path, flash: { notice: "レビューを更新しました。" }
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
      redirect_back fallback_location: root_path, flash: { notice: "他人のレビューは削除できません" }
    end
  end

  def search
    @reviews = Review.search(params[:keyword]).all.order(created_at: :desc)
  end


  private

  def review_params
    params.require(:review).permit(:comment, :star).
    merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end



end
