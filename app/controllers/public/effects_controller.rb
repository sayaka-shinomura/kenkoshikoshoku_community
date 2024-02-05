class Public::EffectsController < ApplicationController
  def index
    @effects = Effect.all
  end

  def show
    @effect = Effect.find(params[:id])
    @nutrients = []
    @vegetables = []
    @effect.nutrients.each do |nutrient|
      @nutrients << nutrient.name
      nutrient.vegetables.each do |vegetable|
        @vegetables << vegetable.name
      end
    end
  end
end
