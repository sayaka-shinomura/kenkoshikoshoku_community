class Public::NutrientsController < ApplicationController

  def index
    @nutrients = Nutrient.order :name
  end

  def show
    @nutrient = Nutrient.find(params[:id])
    @effects = []
    @vegetables = []
    @nutrient.effects.each do |effect|
       @effects << effect.name
    end
    @nutrient.vegetables.each do |vegetable|
       @vegetables << vegetable.name

    end
  end

end
