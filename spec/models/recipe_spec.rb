# frozen_string_literal: true

require 'rails_helper'

describe 'レシピ登録' do
  it "正しく登録できる" do
    expect(FactoryBot.build(:recipe)).to be_valid
  end


end

