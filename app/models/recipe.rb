class Recipe < ApplicationRecord
  
  
  
  has_one_attached :recipe_image
  
  #難易度評価
  enum difficulty: { ☆: 1, ☆☆: 2, ☆☆☆: 3, ☆☆☆☆: 4, ☆☆☆☆☆: 5}
  
  
end
