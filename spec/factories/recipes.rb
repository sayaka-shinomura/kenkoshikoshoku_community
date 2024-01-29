FactoryBot.define do
  factory :recipe, class: Recipe do
    name { 'テストタイトル' }
    summary { 'テスト要約' }
    introduction { 'テスト紹介' }
    time { '15' }
    difficulty { 1 }


    trait :with_ingredients do
      after(:build) do |recipe|
        ingredient = build(:ingredients)
        recipe.ingredients << ingredient
      end
    end

    trait :with_cookerys do
      after(:build) do |recipe|
        cookery = build(:cookerys)
        recipe.cookerys << cookery
      end
    end

    factory :other_recipe do
      name { 'テストタイトル2' }
      summary { 'テスト要約2' }
      introduction { 'テスト紹介2' }
      time { '20' }
      difficulty { '2' }
    end
  end
end