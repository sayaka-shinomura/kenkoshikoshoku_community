require "rails_helper"

RSpec.describe "レビュー機能", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { build(:recipe) }
  let(:posted_recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: user.id) }
  let(:review) { build(:review, recipe_id: recipe.id, user_id: user.id) }
  let(:posted_review) { create(:review, recipe_id: recipe.id, user_id: user.id) }

  before do
    sign_in user
  end

  describe "レビュー投稿画面のテスト" do
    before do
      visit recipe_path(posted_recipe)
    end

    context "表示の確認" do
      it "レシピ詳細画面にレビュー投稿" do
        expect(page).to have_content "レビュー投稿はこちらから"
      end
    end

    context 'フォームの入力値が正常'do
      it '正常に登録される' do
        visit recipe_path(posted_recipe)
        fill_in "review[star]", with: '4'
        fill_in "review[comment]", with: "テストレビュー"
        click_button 'レビューを投稿する'
        expect(page).to have_content("レビューを投稿しました")
        expect(page).to have_content( review.star )
        expect(page).to have_content( review.comment )
      end
    end
  end
end