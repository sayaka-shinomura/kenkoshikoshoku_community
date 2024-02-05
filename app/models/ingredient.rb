class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :content, presence: true
  validates :quantity, presence: true
end
