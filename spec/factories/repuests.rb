FactoryBot.define do
  factory :request do
    content { "テストリクエスト"}
    confirm { true }
    reply { "テスト対応" }
  end

  factory :other_request do
    content { "テストリクエスト2" }
    confirm { false }
    reply { "テスト対応2" }
  end

end