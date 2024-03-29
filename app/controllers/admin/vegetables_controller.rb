class Admin::VegetablesController < ApplicationController
  before_action :authenticate_admin!

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
      redirect_to admin_vegetable_path(@vegetable.id), flash: { notice: "「#{@vegetable.name}」を登録しました。" }
    else
      flash.now[:notice] = "【！】必要事項が入力されていません。"
      render :new
    end
  end

  def show
    @vegetable = Vegetable.find(params[:id])

    # 配列の最初に空を作成
    @nutrients = []
    @effects = []
    @vegetable.nutrients.each do |nutrient|
      @nutrients << nutrient.name
      nutrient.effects.each do |effect|
        # 配列に効能名を入れる
        @effects << effect.name
      end
    end
  end

  def edit
    @vegetable = Vegetable.find(params[:id])
  end

  def update
    @vegetable = Vegetable.find(params[:id])
    if @vegetable.update(vegetable_params)
      redirect_to admin_vegetable_path(@vegetable.id), flash: { notice: "「#{@vegetable.name}」を更新しました。" }
    else
      flash.now[:notice] = "【！】必要事項が入力されていません。"
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
      params.require(:vegetable).permit(
        :vegetable_image,
        :name,
        :seasonal,
        :production_area,
        :keeping,
        :introduction,
        nutrient_ids: [])
    end
end
