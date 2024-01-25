require 'rails_helper'

RSpec.describe "レシピ機能", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { build(:recipe) }
  let(:posted_recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: user.id) }

  before do
    sign_in user #=> サインイン状態になる
  end

  describe 'レシピ投稿画面のテスト' do
    before do
      visit new_recipe_path
    end
    context '表示の確認' do
      it 'レシピ投稿画面にレシピ投稿' do
        expect(page).to have_content 'レシピ投稿'
      end
      it 'new_recipe_pathが"/recipes/new"であるか' do
        expect(current_path).to eq('/recipes/new')
      end
    end
    context 'フォームの入力値が正常' do
      it '正常に登録される' do
        visit new_recipe_path
        expect(page).to have_content("レシピ投稿")
        fill_in 'recipe[name]', with: recipe.name
        fill_in 'recipe[summary]', with: recipe.summary
        fill_in 'recipe[introduction]', with: recipe.introduction
        fill_in 'recipe[time]', with: recipe.time
        select '★', from: 'recipe[difficulty]'
        click_button "材料を追加"
        find('input[name="recipe[ingredients_attributes][0][content]"]').set("内容1")
        find('input[name="recipe[ingredients_attributes][0][quantity]"]').set("分量1")
        click_button "手順を追加"
        find('textarea[name="recipe[cookerys_attributes][0][process]"]').set("手順1")

        expect { click_button 'レシピを投稿する' }.to change { Recipe.count }.by(1)
        expect(page).to have_content("「テストタイトル」のレシピを投稿しました。")
        expect(page).to have_content("内容1")
        expect(page).to have_content("分量1")
        expect(page).to have_content("手順1")
      end
    end
  end




end