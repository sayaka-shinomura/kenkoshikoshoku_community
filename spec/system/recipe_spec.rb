require 'rails_helper'

RSpec.describe "レシピ機能", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { build(:recipe) }
  let(:posted_recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: user.id) }


  describe 'レシピ新規登録機能' do
    context 'フォームの入力値が正常' do
      it '正常に登録される' do
        visit new_recipe_path
        expect(page).to have_content("レシピ投稿")
        fill_in 'recipe[name]', with: recipe.name
        click_link "材料を追加"
        find(".ingredient__content").set("内容1")
        find(".ingredient__quantity").set("分量1")
        click_link "手順を追加"
        find(".cookery__input").set("作り方1")

        expect { click_button '送信する' }.to change { Recipe.count }.by(1)
        expect(page).to have_content("「テストタイトル」のレシピを投稿しました。")
        expect(page).to have_content("内容1")
        expect(page).to have_content("分量1")
        expect(page).to have_content("作り方")
      end
    end


  end


end