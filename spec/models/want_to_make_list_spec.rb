require "rails_helper"

RSpec.describe WantToMakeList, type: :model do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: user.id) }
  let(:want_to_make_list) { user.want_to_make_lists.create(recipe_id: recipe.id)}
  let(:destroy_want_to_make_list) { user.want_to_make_lists.find_by(recipe_id: recipe.id).destroy }

  describe '作ってみたいリスト' do
    context '作ってみたいリストに登録可能' do
      it "user_idとrecipe_idがあれば保存できる" do
        expect(want_to_make_list).to be_valid
      end

      it "リストに登録" do
        expect(want_to_make_list.user_id).to eq 1
        expect(want_to_make_list.recipe.name).to eq "テストタイトル"
        expect(user.want_to_make_lists.count).to eq 1
      end

      it "リスト登録済みであればリスト解除可能" do
        expect{ want_to_make_list }.to change{ WantToMakeList.count }.by(1)
        expect{ destroy_want_to_make_list }.to change{ WantToMakeList.count }.by(-1)
        expect(user.want_to_make_lists.count).to eq 0
      end
    end
  end
end