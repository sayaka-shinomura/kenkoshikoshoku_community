class Admin::VegetablesController < ApplicationController

  def index
    @vegetables = Vegetable.all
  end

  def new
    @vegetable = Vegetable.new
  end

  def create
    @vegetable = Vegetable.new(vegetable_params)
    if @vegetable.save
      redirect_to admin_vegetable_path(@vegetable.id)
    else
      @vegetables = Vegetable.all
      render :new
    end
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @vegetables = Vegetable.all
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

  private

  def vegetable_params
    params.require(:vegetable).permit(:vegetable_image, :name, :seasonal, :production_area, :keeping, :introduction)
  end

end
