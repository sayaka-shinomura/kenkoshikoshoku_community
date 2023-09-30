class Effect < ApplicationRecord

  has_many :effect_tags, dependent: :destroy
  has_many :nutrients, through: :effect_tags, dependent: :destroy


end
