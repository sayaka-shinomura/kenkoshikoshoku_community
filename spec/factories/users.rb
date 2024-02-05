FactoryBot.define do
  factory :user do
    account_name { "sora" }
    email { Faker::Internet.email }
    telephone_number { "09000000001" }
    birth_date { "19990101" }
    gender { "0" }
    password { "password" }
  end

  factory :other_user do
    account_name { Faker::Internet.username }
    email { Faker::Internet.email }
    telephone_number { "09000000001" }
    birth_date { "19990202" }
    gender { "1" }
    password { "password2" }
  end
end
