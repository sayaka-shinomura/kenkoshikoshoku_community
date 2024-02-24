require "rails_helper"

RSpec.describe "リクエスト機能", type: :system do
  let(:user) { create(:user) }
  let(:request) { build(:request) }
  let(:posted_request) { create(:request, user_id: user.id) }


  before do
    expect(FactoryBot.build(:user)).to be_valid
    sign_in user
  end

  describe 'リクエスト投稿のテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it "Top画面にリクエスト投稿フォーム" do
        expect(page).to have_content "ご意見・ご要望"
      end
    end

    context 'フォームの入力値が正常' do
      it '正常に登録される' do
        fill_in "request[content]", with: request.content
        expect { click_button "リクエストを投稿する" }.to change { Request.count }.by(1)
        expect(current_path).to eq request_path(Request.last)
        expect(page).to have_content("ご意見・ご要望を投稿しました。")
        expect(page).to have_content("リクエスト投稿詳細")
        expect(page).to have_content("テストリクエスト")
        expect(page).to have_content("管理者に通知しました")
        click_link "リクエスト一覧へ戻る"
        expect(current_path).to eq requests_path
        expect(page).to have_content("皆様からのご意見・ご要望")
        click_link "詳細を見る"
        expect(current_path).to eq request_path(Request.last)
        expect(page).to have_content("リクエスト投稿詳細")
      end
    end

    context 'フォームの入力値が異常' do
      it 'リクエスト内容が入力されていないため登録不可' do
        fill_in "request[content]", with: nil
        expect { click_button "リクエストを投稿する" }.to change { Request.count }.by(0)
        expect(page).to have_content("【！】空欄で投稿はできません。入力をお願いします。")
      end
    end
  end

  describe "対応機能" do
    before do
      visit admin_session_path
      admin = create(:admin, email: "admin@test.com",
                             password: "000000")
      sign_in admin
    end

    context "対応反映可能" do
      it "正常な値入力がれきていれば反映可能" do
        posted_request
        visit admin_requests_path
        expect(page).to have_content "リクエスト投稿一覧【新着順】"
        click_link "詳細"
        expect(current_path).to eq admin_request_path(Request.last)
        expect(page).to have_content "リクエスト詳細情報"
        click_link "リクエスト対応を行う"
        expect(current_path).to eq edit_admin_request_path(Request.last)
        expect(page).to have_content "リクエスト対応処理"
        fill_in "request[reply]", with: request.reply
        choose "対応済み"
        click_button "リクエスト対応を行う"
        expect(current_path).to eq admin_request_path(Request.last)
        expect(page).to have_content "対応済み"
        visit request_path(Request.last)
        expect(page).to have_content "管理者が対応致しました"
      end

      it "対応内容が空欄で登録" do
        posted_request
        visit edit_admin_request_path(Request.last)
        fill_in "request[reply]", with: nil
        click_button "リクエスト対応を行う"
        expect(current_path).to eq admin_request_path(Request.last)
        expect(page).to have_content "管理者がご意見・ご要望内容を確認しております。"
      end
    end
  end

end