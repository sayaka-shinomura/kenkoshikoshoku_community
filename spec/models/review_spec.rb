require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, :with_ingredients, :with_cookerys, user_id: other_user.id) }
  let(:review) { build(:review, user_id: user.id) }

  describe "正常系" do
    it '正しくレビュー投稿できること' do
      expect(review.star).to eq 4
      expect(review.comment).to eq('テストコメント')
    end
  end

  describe "異常系" do
    context "未入力だとレビュー投稿不可" do
      it '未入力の場合、レビュー投稿ができない' do
        review = build(:review, star: nil)
        review.valid?

        expect(review.errors[:star]).to include("を入力してください")
      end
    end
  end
end