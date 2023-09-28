class Effect < ApplicationRecord

  has_many :effect_tags, dependent: :destroy, foreign_key: 'effect_id'
  has_many :nutrients, through: :effect_tags

end
