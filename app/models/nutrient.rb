class Nutrient < ApplicationRecord
  has_many :effect_tags, dependent: :destroy
  has_many :effects, through: :effect_tags

end
