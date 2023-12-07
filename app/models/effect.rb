class Effect < ApplicationRecord

  has_many :effect_tags, dependent: :destroy
  has_many :nutrients, through: :effect_tags, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true


  def self.looks(search, word)
    if search == "perfect_match"
      @effect = Effect.where("name LIKE?","#{word}")
    elsif search == "partial_match"
      @effect = Effect.where("name LIKE?","%#{word}%")
    else
      @effect = Effect.all
    end
  end


end
