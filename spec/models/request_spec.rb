require "rails_helper"

RSpec.describe Request, type: :model do
  before do
    @user = create(:user)
  end

  let(:user) { @user }
  let(:request) { build(:request, user_id: user.id) }

  describe "正常登録" do
    it "正しくリクエスト投稿できる" do
      expect(request.user_id).to eq 1
      expect(request.content).to eq "テストリクエスト"
      expect(request.confirm).to eq true
    end
  end

  describe "投稿できない場合" do
    it "リクエスト内容は必須であること" do
      request.content = nil
      request.valid?
      expect(request.errors[:content]).to include("を入力してください")
    end
  end


end