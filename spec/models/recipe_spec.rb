# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }
  let(:recipe) { build(:recipe, user_id: user.id) }


  describe "正常登録" do
    it "正しくレシピ投稿できる" do
      ingredient = Ingredient.new(content: "材料1", quantity: "分量1")
      cookery = Cookery.new(process: "手順1")
      recipe.save

      expect(recipe.name).to eq('テストタイトル')
      expect(recipe.introduction).to eq('テスト紹介')
      expect{recipe.ingredients << ingredient}.to change{recipe.ingredients.to_a}.from([]).to([ingredient])
      expect{recipe.cookerys << cookery}.to change{recipe.cookerys.to_a}.from([]).to([cookery])

      expect(recipe).to be_valid
    end
  end

  describe "投稿できない場合" do
    context "必須入力であること" do
      it "レシピ名とレシピ紹介は必須であること" do
        recipe = Recipe.new
        recipe.valid?
        expect(recipe.errors[:name]).to include("を入力してください")
        expect(recipe.errors[:introduction]).to include("を入力してください")
      end

      it "材料と作り方は必須であること" do
        recipe.save
        recipe.valid?
        expect(recipe.errors.full_messages.first).to eq("材料は1つ以上登録してください")
        expect(recipe.errors.full_messages.second).to eq("作り方は1つ以上登録してください")
      end

      it "材料が未記入だと登録不可" do
        ingredient = Ingredient.new(content: nil, quantity: nil)
        recipe.ingredients << ingredient
        recipe.save

        recipe.valid?
        expect(recipe.errors.full_messages.first).to eq("Ingredients contentを入力してください")
      end

      it "作り方が未記入だと登録不可" do
        cookery = Cookery.new(process: nil)
        recipe.cookerys << cookery
        recipe.save

        recipe.valid?
        expect(recipe.errors.full_messages.first).to eq("Cookerys processを入力してください")
      end

    end

  end
end