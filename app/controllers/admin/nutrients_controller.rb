class Admin::NutrientsController < ApplicationController


  def index
    @nutrients = Nutrient.page(params[:page]).per(10)
  end

  def new
    @nutrient = Nutrient.new
    @nutrient.effect_tags.build
  end

  def create
    @nutrient = Nutrient.new(nutrient_params)
    if @nutrient.save
      redirect_to admin_nutrient_path(@nutrient.id)
    else
      render :new
    end
  end

  def show
    @nutrient = Nutrient.find(params[:id])
  end

  def edit
     @nutrient= Nutrient.find(params[:id])
  end

  def update
     @nutrient = Nutrient.find(params[:id])
    if @nutrient.update(nutrient_params)
      redirect_to admin_nutrient_path(@nutrient.id)
    else
      render :edit
    end
  end

  def destroy
    @nutrient = Nutrient.find(params[:id])
    @nutrient.destroy
    flash[:notice] = "削除を実行しました"
    redirect_to admin_nutrients_path
  end


  private


  def nutrient_params
    params.require(:nutrient).permit(:name, :introduction, effect_ids: [])
  end


end
