class Nutrient < ApplicationRecord

  belongs_to :vegetable
  has_many :effects

end
