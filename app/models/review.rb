class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipe

  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  def self.search(search)
    if search != ""
      Review.where(['recipe_id LIKE(?) OR user_id LIKE(?) OR comment LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Review.includes(:user).order('created_at DESC')
    end
  end

end
