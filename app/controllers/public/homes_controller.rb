class Public::HomesController < ApplicationController
  def top
    @vegetable_ranks = Vegetable.find(VegetableTag.group(:vegetable_id).order("count(vegetable_id) desc").limit(10).pluck(:vegetable_id))
    @want_ranks = Recipe.find(WantToMakeList.group(:recipe_id).order("count(recipe_id) desc").limit(5).pluck(:recipe_id))
    @made_ranks = Recipe.find(MadeList.group(:recipe_id).order("count(recipe_id) desc").limit(5).pluck(:recipe_id))

    @request = Request.new
    @requests = Request.page(params[:page]).per(3).order(created_at: :desc)

    @vegetables = Vegetable.all
  end

  def about
    @vegetable_ranks = Vegetable.find(VegetableTag.group(:vegetable_id).order("count(vegetable_id) desc").limit(10).pluck(:vegetable_id))
    @want_ranks = Recipe.find(WantToMakeList.group(:recipe_id).order("count(recipe_id) desc").limit(5).pluck(:recipe_id))
    @made_ranks = Recipe.find(MadeList.group(:recipe_id).order("count(recipe_id) desc").limit(5).pluck(:recipe_id))
  end
end
