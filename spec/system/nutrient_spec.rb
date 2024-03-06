require "rails_helper"

RSpec.describe "栄養素関連機能", type: :system do
  let(:admin) { create(:admin) }
  let(:effect_tags) { build(:effect_tags) }
  let(:nutrient) { create(:nutrient) }
  let(:posted_nutrient) { create(:nutrient) }

  before do
    sign_in admin
  end

  describe '栄養素情報投稿テスト' do
    before do
      visit admin_nutrients_path
    end

    context '表示の確認' do
      it "栄養素一覧画面に新規登録リンク" do
        expect(page).to have_content "栄養素一覧"
        expect(page).to have_content "新規登録"
      end
    end

    context 'フォームの入力値が正常' do
      it '正常に登録される' do
        effect = create(:effect, name: "テスト効能名")
        click_link "新規登録"
        expect(current_path).to eq new_admin_nutrient_path
        expect(page).to have_content "栄養素情報登録"
        fill_in "nutrient[name]", with: "テスト栄養素名"
        fill_in "nutrient[introduction]", with: "テスト栄養素概要"
        check "テスト効能名"
        expect { click_button "新規登録" }.to change { Nutrient.count }.by(1)
        expect(current_path).to eq admin_nutrient_path(Nutrient.last)
        expect(page).to have_content "登録しました。"
        expect(page).to have_content "栄養素情報詳細"
        expect(page).to have_content "テスト栄養素名"
      end
    end
  end

end