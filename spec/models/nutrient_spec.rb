require 'rails_helper'

RSpec.describe Nutrient, type: :model do
  let(:nutrient) { create(:nutrient) }

  it '栄養素と効能の関連付け' do
    expect(nutrient).to be_valid
  end

  describe "正常登録" do
    it "正しく栄養素情報を投稿できる" do
      expect(nutrient.name).to eq "テスト栄養素名"
      expect(nutrient.introduction).to eq "テスト栄養素詳細"
      expect(nutrient.effect_tags.first.effect.name).to eq "テスト効能名"
    end
  end

  describe "投稿できない場合" do
    it "栄養素名は必須であること" do
      nutrient = Nutrient.new
      nutrient.valid?
      expect(nutrient.errors[:name]).to include("を入力してください")
      expect(nutrient.errors[:introduction]).to include("を入力してください")
    end
  end

end