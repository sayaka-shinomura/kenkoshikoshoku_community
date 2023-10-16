class Public::HomesController < ApplicationController

  def top
    @want_ranks = Recipe.find(WantToMakeList.group(:recipe_id).order('count(recipe_id) desc').limit(5).pluck(:recipe_id))
    @made_ranks = Recipe.find(MadeList.group(:recipe_id).order('count(recipe_id) desc').limit(5).pluck(:recipe_id))
  end


end
