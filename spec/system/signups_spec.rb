# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ユーザー新規登録", type: :system do
  let!(:user) { build(:user) }

  describe "正しく登録" do
    context "フォームの入力値が正常" do
      it "正確な情報を入力したら登録可能" do
        visit new_user_registration_path
        expect(page).to have_content("新規登録")
        fill_in "user_account_name", with: user.account_name
        fill_in "user_email", with: user.email
        fill_in "user_telephone_number", with: user.telephone_number
        fill_in "user_birth_date", with: user.birth_date
        choose "男性"
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password
        expect { click_button "新規登録" }.to change { User.count }.by(1)
        expect(current_path).to eq "/users/mypage"
      end
    end
  end

  describe "登録できなかった場合" do
    context "フォームの入力値が異常のため登録不可" do
      it "メールアドレスが入っていないため再度登録ページへ" do
        visit new_user_registration_path
        expect(page).to have_content("新規登録")
        fill_in "user_account_name", with: user.account_name
        fill_in "user_email", with: nil
        fill_in "user_telephone_number", with: user.telephone_number
        fill_in "user_birth_date", with: user.birth_date
        choose "男性"
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password
        expect { click_button "新規登録" }.to change { User.count }.by(0)
        expect(current_path).to eq "/users"
        expect(page).to have_content("メールアドレスを入力してください")
      end
    end
  end
end
