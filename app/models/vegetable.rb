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


  def self.looks(search, word)
    if search == "perfect_match"
      @vegetable = Vegetable.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @vegetable = Vegetable.where("name LIKE?", "%#{word}%")
    else
      @vegetable = Vegetable.all
    end
  end

  def self.search(search)
    if search != ""
      Vegetable.joins(:nutrients, nutrients: :effects)
      .where(["nutrients.name LIKE(?) OR effects.name LIKE(?)",
      "%#{search}%", "%#{search}%"])
    else
      Vegetable.all
    end
  end
end
