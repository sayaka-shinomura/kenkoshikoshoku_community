class Public::RecipesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]


  def index
    @recipes = @recipes.page(params[:page]).per(6)
  end

  def new
    @recipe = Recipe.new
    @recipe.vegetable_tags.build
    @ingredient = @recipe.ingredients.build
  end

  def create
     @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe.id), flash: { notice: "「#{recipe.name}」のレシピを投稿しました。" }
    else
      render :new
    end
  end
  def show

    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, flash: { notice: "「#{@recipe.name}」のレシピを更新しました。" }
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_path(current_user.id), flash: { notice: "「#{@recipe.name}」のレシピを削除しました。" }
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
      ingredients_attributes: [:id, :recipe_id, :content, :quantity, :_destroy],
      cookerys_attributes: [:id, :recipe_id, :process, :_destroy])
  end



end
