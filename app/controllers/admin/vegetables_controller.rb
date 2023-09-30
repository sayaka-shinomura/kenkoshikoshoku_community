class Admin::VegetablesController < ApplicationController

  def index
    @vegetables = Vegetable.page(params[:page]).per(10)
  end

  def new
    @vegetable = Vegetable.new
    @vegetable.nutrient_tags.build
  end

  def create
    @vegetable = Vegetable.new(vegetable_params)
    if @vegetable.save
      redirect_to admin_vegetable_path(@vegetable.id)
    else
      render :new
    end
  end

  def show
    @vegetable = Vegetable.find(params[:id])
  end

  def edit
    @vegetable = Vegetable.find(params[:id])
  end

  def update
     @vegetable = Vegetable.find(params[:id])
    if @vegetable.update(vegetable_params)
      redirect_to admin_vegetable_path(@vegetable.id)
    else
      render :edit
    end
  end

  def destroy
    @vegetable = Vegetable.find(params[:id])
    @vegetable.destroy
    flash[:notice] = "削除を実行しました"
    redirect_to admin_vegetables_path
  end


  private


  def vegetable_params
    params.require(:vegetable).permit(:vegetable_image, :name, :seasonal, :production_area, :keeping, :introduction, nutrient_ids: [])
  end

end
