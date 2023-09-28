class Admin::NutrientsController < ApplicationController

  def index
    @nutrients = Nutrient.page(params[:page]).per(10)
  end

  def new
    @nutrient = Nutrient.new
    @effect = Effect.all
  end

  def create
    @nutrient = Nutrient.new(nutrient_params)
    if @nutrient.save
      redirect_to admin_nutrient_path(@nutrient.id)
    else
      @effect = Effect.all
      render :new
    end
  end

  def show
    @nutrient = Nutrient.find(params[:id])
    @nutrients = Nutrient.all

    byebug
  end

  def edit
    @nutrient = Nutrient.find(params[:id])
    @effect = Effect.all
  end

  def update
     @nutrient = Nutrient.find(params[:id])
     @effects = Effect.all
    if @nutrient.update(nutrient_params)
      redirect_to admin_nutrient_path(@nutrient.id)
    else
      render :edit
    end
  end

  def destroy
    @nutrient = Nutrient.find(params[:id])
    @effects = Effect.all
    @nutrient.destroy
    flash[:notice] = "削除を実行しました"
    redirect_to admin_nutrients_path
  end

  private

  def nutrient_params
    params.require(:nutrient).permit(:name, :introduction)
  end

  def update_params
    params.require(:nutrient).permit({:effects_ids => []})
  end

end
