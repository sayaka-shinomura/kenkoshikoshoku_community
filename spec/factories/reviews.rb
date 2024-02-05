FactoryBot.define do
  factory :review, class: Review do
    star { "4" }
    comment { "テストコメント" }
  end
end
