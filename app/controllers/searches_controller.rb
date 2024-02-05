class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "Recipe"
      @recipes = Recipe.looks(params[:search], params[:word])
    elsif @range == "Vegetable"
      @vegetables = Vegetable.looks(params[:search], params[:word])
    elsif @range == "Nutrient"
      @nutrients = Nutrient.looks(params[:search], params[:word])
    else
      @effects = Effect.looks(params[:search], params[:word])
    end
  end
end
