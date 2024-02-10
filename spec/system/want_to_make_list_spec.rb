require "rails_helper"

RSpec.describe "作ってみたいリスト機能", type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: user.id) }
  let(:want_to_make_list) { user.want_to_make_lists.create(recipe_id: recipe.id)}
  let(:destroy_want_to_make_list) { user.want_to_make_lists.find_by(recipe_id: recipe.id).destroy }

  before do
    expect(FactoryBot.build(:user)).to be_valid
    sign_in user
    other_user = create(:user, account_name: "other_user",
                               email: "other@example.com",
                               telephone_number: "09000000001",
                               birth_date: "09000000002",
                               gender: "1",
                               password: "password2")
    sign_in other_user  #=> other_userでサインイン状態になる
  end


  describe '作ってみたいリストのテスト' do
    before do
      visit recipe_path(recipe)
    end

    context "表示の確認" do
      it "レシピ詳細画面にリストのボタン" do
        expect(page).to have_content "作ってみたいリストに登録"
      end
    end

    context 'レシピ詳細ページからのリスト登録機能について' do
      it 'リスト登録する' do
        visit recipe_path(recipe)
        click_on "作ってみたいリストに登録"
        expect(page).to have_content("作ってみたいリストに登録しました。")
        expect(page).to have_content "作ってみたいリストから解除"
      end
    end
  end
end