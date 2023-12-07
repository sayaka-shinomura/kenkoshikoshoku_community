class Nutrient < ApplicationRecord

  has_many :effect_tags, dependent: :destroy
  has_many :effects, through: :effect_tags

  has_many :nutrient_tags, dependent: :destroy
  has_many :vegetables, through: :nutrient_tags, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @nutrient = Nutrient.where("name LIKE?","#{word}")
    elsif search == "partial_match"
      @nutrient = Nutrient.where("name LIKE?","%#{word}%")
    else
      @nutrient = Nutrient.all
    end
  end

end
