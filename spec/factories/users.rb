FactoryBot.define do
  factory :user do
    account_name { 'sara' }
    email { Faker::Internet.email }
    telephone_number { '12345678901' }
    birth_date { '19990101' }
    gender { '1' }
    encrypted_password { 'password' }

  end
end
