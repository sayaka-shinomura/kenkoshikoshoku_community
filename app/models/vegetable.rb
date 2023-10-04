class Vegetable < ApplicationRecord

  has_one_attached :vegetable_image

  has_many :nutrient_tags, dependent: :destroy
  has_many :nutrients, through: :nutrient_tags

  has_many :vegetable_tags, dependent: :destroy
  has_many :recipes, through: :vegetable_tags, dependent: :destroy

  validates :name, presence: true
  validates :seasonal, presence: true
  validates :production_area, presence: true
  validates :keeping, presence: true
  validates :introduction, presence: true


end
