class Nutrient < ApplicationRecord

  has_many :effect_tags, dependent: :destroy
  has_many :effects, through: :effect_tags

  has_many :nutrient_tags, dependent: :destroy
  has_many :vegetables, through: :nutrient_tags, dependent: :destroy

end
