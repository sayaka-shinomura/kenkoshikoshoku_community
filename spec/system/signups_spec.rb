# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  let(:user) { build(:user) }

  describe '正しく登録' do
    context 'フォームの入力値が正常' do
      it '正確な情報を入力したら登録可能' do
        visit new_user_registration_path
        expect(page).to have_content('新規登録')
        fill_in 'user_account_name', with: user.account_name
        fill_in 'user_email', with: user.email
        fill_in 'user_telephone_number', with: user.telephone_number
        fill_in 'user_birth_date', with: user.birth_date
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation

        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
    end
  end


end