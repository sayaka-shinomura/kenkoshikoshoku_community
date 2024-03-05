require "rails_helper"

RSpec.describe "効能投稿機能", type: :system do
  let(:admin) { create(:admin) }
  let(:effect) { build(:effect) }
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

  describe "編集機能" do
    context "変更反映可能" do
      it "一覧画面から変更反映可能" do
        posted_effect
        visit admin_effects_path
        expect(page).to have_content "効能一覧"
        click_link "編集"
        expect(current_path).to eq edit_admin_effect_path(Effect.last)
        expect(page).to have_content "効能情報編集"
        expect(page).to have_field "effect[name]", with: "テスト効能名"
        expect(page).to have_field "effect[introduction]", with: effect.introduction
        fill_in "effect[introduction]", with: "テスト効能概要"
        click_button "保存"
        expect(current_path).to eq admin_effect_path(Effect.last)
        expect(page).to have_content "更新しました。"
        expect(page).to have_content "テスト効能名"
      end

      it "詳細画面から変更可能" do
        posted_effect
        visit admin_effects_path
        click_link "詳細"
        expect(current_path).to eq admin_effect_path(Effect.last)
        expect(page).to have_content "効能情報詳細"
        click_link "編 集"
        expect(current_path).to eq edit_admin_effect_path(Effect.last)
        expect(page).to have_content "効能情報編集"
        expect(page).to have_field "effect[name]", with: "テスト効能名"
        expect(page).to have_field "effect[introduction]", with: effect.introduction
        fill_in "effect[introduction]", with: "テスト効能概要"
        click_button "保存"
        expect(current_path).to eq admin_effect_path(Effect.last)
        expect(page).to have_content "更新しました。"
        expect(page).to have_content "テスト効能名"
      end
    end

    context "フォームの入力値が異常" do
      it "効果名を未入力にしたら変更反映不可" do
        visit edit_admin_effect_path(posted_effect)
        fill_in "effect[name]", with: nil
        click_button "保存"
        expect(page).to have_content "【！】必要事項が入力されていません。"
      end

      it "効能概要を未入力にしたら変更反映不可" do
        visit edit_admin_effect_path(posted_effect)
        fill_in "effect[introduction]", with: nil
        click_button "保存"
        expect(page).to have_content "【！】必要事項が入力されていません。"
      end
    end
  end

  describe "削除機能" do
    it "管理者ページから削除可能" do
      posted_effect
      visit admin_effects_path
      expect(page).to have_content "削除"
      click_link "削除"
      expect(page).to have_content "削除を実行しました"
    end
  end
ends