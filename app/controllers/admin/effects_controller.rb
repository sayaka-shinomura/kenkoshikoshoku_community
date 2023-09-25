class Admin::EffectsController < ApplicationController

  def index
    @effects = Effect.all
  end

  def new
    @effect = Effect.new
  end

  def create
    @effect = Effect.new(effect_params)
    if @effect.save
      redirect_to admin_effect_path(@effect.id)
    else
      @effects = Effect.all
      render :new
    end
  end

  def show
    @effect = Effect.find(params[:id])
    @effects = Effect.all
  end

  def edit
    @effect = Effect.find(params[:id])
  end

  def update
     @effect = Effect.find(params[:id])
    if @effect.update(effect_params)
      redirect_to admin_effect_path(@effect.id)
    else
      render :edit
    end
  end

  private

  def effect_params
    params.require(:effect).permit(:name, :introduction)
  end

end
