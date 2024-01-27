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

    context 'フォームの入力値が異常' do
      it 'レシピのタイトル・説明が入力されていないため登録不可' do
        visit new_recipe_path
        fill_in 'recipe[name]', with: nil
        fill_in 'recipe[summary]', with: recipe.summary
        fill_in 'recipe[introduction]', with: nil
        fill_in 'recipe[introduction]', with: recipe.introduction
        fill_in 'recipe[time]', with: recipe.time
        select '★', from: 'recipe[difficulty]'
        click_button "材料を追加"
        find('input[name="recipe[ingredients_attributes][0][content]"]').set("内容1")
        find('input[name="recipe[ingredients_attributes][0][quantity]"]').set("分量1")
        click_button "手順を追加"
        find('textarea[name="recipe[cookerys_attributes][0][process]"]').set("手順1")

        click_button 'レシピを投稿する'
        expect(page).to have_content("レシピ名を入力してください")
        expect(page).to have_content("【！】必要事項が入力されていません。")
      end

      it 'レシピのタイトルは20文字・説明は200文字を超える場合は登録不可' do
        visit new_recipe_path
        fill_in 'recipe[name]', with:  "a" * 21
        fill_in 'recipe[summary]', with: recipe.summary
        fill_in 'recipe[introduction]', with:  "a" * 201
        fill_in 'recipe[time]', with: recipe.time
        select '★', from: 'recipe[difficulty]'
        click_button "材料を追加"
        find('input[name="recipe[ingredients_attributes][0][content]"]').set("内容1")
        find('input[name="recipe[ingredients_attributes][0][quantity]"]').set("分量1")
        click_button "手順を追加"
        find('textarea[name="recipe[cookerys_attributes][0][process]"]').set("手順1")

        click_button 'レシピを投稿する'
        expect(page).to have_content("【！】必要事項が入力されていません。または文字数制限をお確かめください。")
      end

      it '材料と作り方はそれぞれ1つ以上入っていないと登録不可' do
        visit new_recipe_path
        fill_in 'recipe[name]', with: recipe.name
        fill_in 'recipe[summary]', with: recipe.summary
        fill_in 'recipe[introduction]', with: recipe.introduction
        fill_in 'recipe[time]', with: recipe.time
        select '★', from: 'recipe[difficulty]'
        click_button 'レシピを投稿する'
        expect(page).to have_content("材料は1つ以上登録してください")
        expect(page).to have_content("作り方は1つ以上登録してください")
      end
    end
  end

  describe '編集機能' do
    context '変更反映可能' do
      it '正常な値入力ができていれば反映可能', js: true do
        visit edit_recipe_path(posted_recipe)
        expect(page).to have_field 'recipe[name]', with: recipe.name
        expect(page).to have_field 'recipe[introduction]', with: recipe.introduction
        fill_in 'recipe[name]', with: 'テストタイトル2'
        fill_in 'recipe[introduction]', with: 'テスト紹介2'
        fill_in 'recipe[summary]', with: recipe.summary
        fill_in 'recipe[time]', with: recipe.time
        select '★', from: 'recipe[difficulty]'
        click_button "材料を追加"
        find('input[name="recipe[ingredients_attributes][0][content]"]').set("内容1")
        find('input[name="recipe[ingredients_attributes][0][quantity]"]').set("分量1")
        click_button "手順を追加"
        find('textarea[name="recipe[cookerys_attributes][0][process]"]').set("手順1")
        click_button 'レシピを変更する'
        expect(current_path).to eq recipe_path(posted_recipe)
        expect(page).to have_content(posted_recipe.name)
        expect(page).to have_content(posted_recipe.introduction)
      end
    end

    context 'フォームの入力値が異常' do
      it 'レシピのタイトル・説明を未入力にしたら変更反映不可' do
        visit edit_recipe_path(posted_recipe)
        fill_in 'recipe[name]', with: nil
        fill_in 'recipe[introduction]', with: nil
        click_button 'レシピを変更する'
        expect(page).to have_content("【！】必要事項が入力されていません。")
      end

      it '材料・分量を未入力にしたら変更反映不可' do
        visit edit_recipe_path(posted_recipe)
        find('input[name="recipe[ingredients_attributes][0][content]"]').set(nil)
        find('input[name="recipe[ingredients_attributes][0][quantity]"]').set(nil)
        click_button 'レシピを変更する'
        expect(current_path).to eq recipe_path(posted_recipe)
        expect(page).to have_content("【！】必要事項が入力されていません。")
      end

      it '手順を未入力にしたら変更反映不可' do
        visit edit_recipe_path(posted_recipe)
        find('textarea[name="recipe[cookerys_attributes][0][process]"]').set(nil)
        click_button 'レシピを変更する'
        expect(current_path).to eq recipe_path(posted_recipe)
        expect(page).to have_content("【！】必要事項が入力されていません。")
      end
    end
  end

  describe '削除機能' do
    it 'レシピ詳細ページから削除ボタンを押せばレシピの削除が可能', js: true do
      visit recipe_path(posted_recipe)
      expect(page).to have_content("を使ったレシピ")
      expect(Recipe.count).to eq 1

      click_link 'レシピを削除する'
      expect(page).to have_content("「#{posted_recipe.name}」のレシピを削除しました。")
      expect(Recipe.count).to eq 0
    end
  end

  describe '検索機能' , js: true do
    context "ユーザー名での検索可能" do
      it "部分一致で可能" do
        posted_recipe
        visit recipes_path
        page.all('input[name="keyword"]')[0].set("sora")
        page.all('input[name="commit"]')[0].click
        expect(page).to have_content('レシピ検索結果')
      end
    end
  end


end