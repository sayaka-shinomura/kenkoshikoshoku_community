class MadeList < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  has_one_attached :recipe_image

  validates :user_id, uniqueness: { scope: :recipe_id }
end
