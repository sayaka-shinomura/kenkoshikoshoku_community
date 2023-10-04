class VegetableTag < ApplicationRecord
  
  belongs_to :recipe
  belongs_to :vegetable
  
end
