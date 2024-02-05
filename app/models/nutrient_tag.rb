class NutrientTag < ApplicationRecord
  belongs_to :vegetable
  belongs_to :nutrient
end
