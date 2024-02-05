class Public::WantToMakeListsController < ApplicationController
  before_action :authenticate_user!

  def index
    want_lists = WantToMakeList.where(user_id: current_user.id).pluck(:recipe_id)
    @want_list = Recipe.find(want_lists)
  end

  def create
    @want_to_make_list = current_user.want_to_make_lists.build(want_to_make_list_params)
    @recipe = @want_to_make_list.recipe
    if @want_to_make_list.valid?
      @want_to_make_list.save
      redirect_to recipe_path(@recipe), notice: "作ってみたいリストに登録しました。"
    end
  end

  def destroy
    @want_to_make_list = WantToMakeList.find(params[:id])
    @recipe = @want_to_make_list.recipe
    if @want_to_make_list.destroy
      redirect_to mypage_path, notice: "作ってみたいリストから解除しました。"
    end
  end


  private
    def want_to_make_list_params
      params.permit(:recipe_id)
    end
end
