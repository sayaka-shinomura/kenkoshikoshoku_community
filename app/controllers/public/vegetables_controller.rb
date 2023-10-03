class Public::VegetablesController < ApplicationController


  def index
    @vegetables = Vegetable.page(params[:page]).per(6)
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @nutrients = []
    @effects = []
    @vegetable.nutrients.each do |nutrient|
       @nutrients << nutrient.name
       nutrient.effects.each do |effect|
         @effects << effect.name
       end
    end
  end





end
