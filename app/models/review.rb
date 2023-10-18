class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipe

  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  def self.search(search)
    if search != ""
      Review.joins(:recipe, :user).where(['recipes.name LIKE(?) OR users.account_name LIKE(?) OR comment LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Review.all
    end
  end

end
