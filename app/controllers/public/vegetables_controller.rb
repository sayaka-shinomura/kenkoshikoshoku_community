class Public::VegetablesController < ApplicationController


  def index
    @vegetables = Vegetable.page(params[:page]).per(6)
    @nutrient = Nutrient.all
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @nutrient = Nutrient.find(params[:id])

    #配列の最初に空を作成
    @effects = []
    @vegetable.nutrients.each do |nutrient|
       nutrient.effects.each do |effect|
         #配列に効能名を入れる
         @effects << effect.name
       end
    end
  end





end
