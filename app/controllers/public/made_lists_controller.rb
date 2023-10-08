class Public::MadeListsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def create
    @made_list = current_user.made_lists.build(made_list_params)
    @recipe = @made_list.recipe
    if @made_list.valid?
      @made_list.save
      redirect_to recipe_path(@recipe), notice: "作ってみたリストに登録しました。"
    end
  end

  def destroy
    @made_list = MadeList.find(params[:id])
    @recipe = @made_list.recipe
    if @made_list.destroy
      redirect_to mypage_path, notice: "作ってみたリストから解除しました。"
    end
  end


  private


  def made_list_params
    params.permit(:recipe_id)
  end

end
