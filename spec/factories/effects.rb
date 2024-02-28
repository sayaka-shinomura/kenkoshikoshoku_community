FactoryBot.define do
  factory :effect, class: Effect do
    name { "テスト効能名" }
    introduction { "テスト効能詳細" }
  end

  factory :other_effect do
    name { "テスト効能名2" }
    introduction { "テスト効能詳細2" }
  end
end