require "rails_helper"

RSpec.describe "レビュー機能", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { build(:recipe) }
  let(:posted_recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: user.id) }
  let(:review) { build(:review, user_id: user.id) }
  let(:posted_review) { create(:review, recipe_id: recipe.id, user_id: user.id) }

  before do
    other_user = create(:user, account_name: "other_user",
                               email: "other@example.com",
                               telephone_number: "09000000001",
                               birth_date: "09000000002",
                               gender: "1",
                               password: "password2")
    sign_in other_user  #=> other_userでサインイン状態になる
    visit recipe_path(posted_recipe)
  end

  describe "レビュー投稿画面のテスト" do
    context '正常に登録される' do
      before do
        visit recipe_path(posted_recipe)
        expect(page).to have_content "テストタイトル"
        expect(page).to have_content "レビュー投稿はこちらから"
        expect(page).to have_selector '#post_raty', visible: false
        find('#post_raty', visible: false).set(4)
        fill_in "review[comment]", with: "テストコメント"
      end

      it 'レビューが正常に登録される' do
        #expect(page).to have_content "レビューを投稿する"
        click_button 'commit'
        #byebug
        #expect { click_button "レビューを投稿する" }.to change { Review.count }.by(1)
        expect(page).to have_content(Review.last.star)
        #expect(page).to have_content(Review.last.comment)
      end
    end
  end
end