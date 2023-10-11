class Public::RecipesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]


  def index
    @recipe = Recipe.page(params[:page]).per(6)
    @recipes = params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.vegetable_tags.build
    @recipe.myrecipes.build
    @recipe.ingredients.build
    @recipe.cookerys.build
    @recipe.tags.build
  end

  def create
     @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe.id), flash: { notice: "「#{@recipe.name}」のレシピを投稿しました。" }
    else
      render :new
    end

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

  def show
    @recipe = Recipe.find(params[:id])
    @vegetables = []
    @recipe.vegetables.each do |vegetable|
      @vegetables << vegetable.name
    end

    @review = Review.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      render "edit"
    else
      redirect_back fallback_location: root_path, flash: { alert: "他人のレシピは編集できません" }
    end
  end

  def update
    @recipes = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, flash: { notice: "「#{@recipe.name}」のレシピを更新しました。" }
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      @recipe.destroy
      redirect_to mypage_path, flash: { notice: "「#{@recipe.name}」のレシピを削除しました。" }
    else
      redirect_back fallback_location: root_path, flash: { alert: "他人のレシピは編集できません" }
    end
  end


  private


  def recipe_params
    params.require(:recipe).permit(
      :recipe_image,
      :name,
      :summary,
      :introduction,
      :time,
      :difficulty,
      :user_id,
      vegetable_ids: [],
      tag_ids: [],
      ingredients_attributes: [:id, :recipe_id, :content, :quantity, :_destroy],
      cookerys_attributes: [:id, :process, :_destroy])
  end



end
