class Nutrient < ApplicationRecord

  belongs_to :vegetable, optional: true
  has_many :effects

end
