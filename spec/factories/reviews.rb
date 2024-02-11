FactoryBot.define do
  factory :review, class: Review do
    star { 4 }
    comment { "テストコメント" }
    association :recipe
    association :user
  end
end
