class SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "Recipe"
      @recipes = Recipe.looks(params[:search], params[:word])
    else
      @effects = Effect.looks(params[:search], params[:word])
    end
  end

end
