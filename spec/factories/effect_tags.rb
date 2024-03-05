FactoryBot.define do
  factory :effect_tag do
    association :effect, factory: :effect
  end
end