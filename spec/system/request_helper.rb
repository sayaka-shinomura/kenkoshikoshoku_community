require "rails_helper"

RSpec.describe "リクエスト機能", type: :system do
  let(:user) { create(:user) }
  let(:request) { build(:request) }
  let(:posted_request) { create(:request, user_id: user.id) }


  before do
    expect(FactoyBot.build(:user)).to be_valid
    sign_in user
  end

  describe 'リクエスト投稿のテスト' do
    before do
      visit root_path
    end

    content '表示の確認' do
      it "Top画面にリクエスト投稿フォーム"
       expect(page).to have_content "ご意見・ご要望"
       expect(page).to have_content "リクエストを投稿する"
    end

    content 'フォームの入力値が正常' do
      it '正常に登録される' do
        fill_in "request[content]", with: request.content
        expect { click_button "リクエストを投稿する" }.to change { Request.count }.by(1)
        expect(current_path).to eq request_path(posted_request)
        expect(page).to have_content("ご意見・ご要望を投稿しました。")
        expect(page).to have_content("リクエスト投稿詳細")
        expect(page).to have_content("request.content")
        expect(page).to have_content("管理者に通知しました")
        click_on "リクエスト一覧に戻る"
        expect(current_path).to eq requests_path
        expect(page).to have_content("皆様からのご意見・ご要望")
        expect(page).to have_contet("request.content")
        click_on "詳細を見る"
        expect(current_path).to eq request_path(posted_request)
        expect(page).to have_content("request.content")
      end
    end

    content 'フォームの入力値が異常' do
      it 'リクエスト内容が入力されていないため登録不可' do
        fill_in "request[content]", with: nil
        expect { click_button "リクエストを投稿する" }.to change { Request.conut }.by(0)
        expect(currnt_path).lto eq about_path
        expect(page).to have_content("【！】空欄で投稿はできません。入力をお願いします。")
      end
    end
  end

end