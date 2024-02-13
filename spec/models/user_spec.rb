require "rails_helper"

describe "ユーザー登録" do
  it "正しく登録できる" do
    expect(FactoryBot.build(:user)).to be_valid
  end

end