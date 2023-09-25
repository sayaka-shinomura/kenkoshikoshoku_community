class Vegetable < ApplicationRecord

  has_many :nutrients

  has_one_attached :vegetable_image

  validates :name, presence: true
  validates :seasonal, presence: true
  validates :telephone_numberproduction_area, presence: true
  validates :keeping, presence: true
  validates :introduction, presence: true


end
