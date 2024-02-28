require "rails_helper"

RSpec.describe Effect, type: :model do
  let(:effect) { create(:effect) }

  describe "正常登録" do
    it "正しく効能情報を投稿できる" do
      expect(effect.name).to eq "テスト効能名"
      expect(effect.introduction).to eq "テスト効能詳細"
    end
  end

  describe "投稿できない場合" do
    it "効能名は必須であること" do
      effect = Effect.new
      effect.valid?
      expect(effect.errors[:name]).to include("を入力してください")
      expect(effect.errors[:introduction]).to include("を入力してください")
    end
  end
end