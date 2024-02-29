require "rails_helper"

RSpec.describe "効能投稿機能", type: :system do
  let(:admin) { create(:admin) }
  let(:effect) { create(:effect) }
  let(:posted_effect) { create(:effect) }

  before do
    sign_in admin
  end

  describe '効能情報投稿のテスト' do
    before do
      visit admin_effects_path
    end

    context '表示の確認' do
      it "効能一覧画面に新規登録リンク" do
        expect(page).to have_content "効能一覧"
        expect(page).to have_link "新規登録"
      end
    end

    context 'フォームの入力値が正常' do
      it '正常に登録される' do
        click_link "新規登録"
        expect(current_path).to eq new_admin_effect_path
        expect(page).to have_content "効能情報登録"
        fill_in "effect[name]", with: "テスト効能名"
        fill_in "effect[introduction]", with: effect.introduction
        expect { click_button "新規登録" }.to change { Effect.count }.by(1)
        expect(current_path).to eq admin_effect_path(Effect.last)
        expect(page).to have_content "登録しました。"
        expect(page).to have_content "効能情報詳細"
        expect(page).to have_content "テスト効能名"
      end
    end

    context 'フォームの入力値が異常' do
      it '効能名が入力されていないため登録不可' do
        click_link "新規登録"
        expect(current_path).to eq new_admin_effect_path
        expect(page).to have_content "効能情報登録"
        fill_in "effect[name]", with: nil
        fill_in "effect[introduction]", with: effect.introduction
        expect { click_button "新規登録" }.to change { Effect.count }.by(0)
        expect(page).to have_content "【！】必要事項が入力されていません。"
      end

      it '効能概要が入力されていないため登録不可' do
        click_link "新規登録"
        expect(current_path).to eq new_admin_effect_path
        expect(page).to have_content "効能情報登録"
        fill_in "effect[name]", with: effect.name
        fill_in "effect[introduction]", with: nil
        expect { click_button "新規登録" }.to change { Effect.count }.by(0)
        expect(page).to have_content "【！】必要事項が入力されていません。"
      end
    end
  end
end