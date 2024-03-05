require 'rails_helper'

RSpec.describe Nutrient, type: :model do
  let(:nutrient) { create(:nutrient) }
  
  it '栄養素と効能の関連付け' do
    expect(nutrient).to be_valid
  end
  
  

end