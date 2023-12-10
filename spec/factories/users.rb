FactoryBot.define do
  factory :user do
    account_name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    telephone_number { Faker::Lorem.characters(number: 11) }
    birth_date { Faker::Lorem.characters(number: 8) }
    password { 'password' }
    password_confirmation { 'password' }
    
  end
end
