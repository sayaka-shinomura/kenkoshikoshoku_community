FactoryBot.define do
  factory :user do
    account_name { 'sora' }
    email { Faker::Internet.email }
    telephone_number { '09000000001' }
    birth_date { '19990101' }
    gender { '0' }
    password { 'password' }
  end
end
