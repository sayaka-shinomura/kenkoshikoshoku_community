FactoryBot.define do
  factory :nutrient do
    name { "テスト栄養素名" }
    introduction { "テスト栄養素詳細" }

    after(:build) do |nutrient|
      nutrient.effect_tags << FactoryBot.build(:effect_tag)
    end
  end
end