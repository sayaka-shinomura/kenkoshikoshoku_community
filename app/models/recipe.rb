class Recipe < ApplicationRecord

  has_many :vegetable_tags, dependent: :destroy
  has_many :vegetables, through: :vegetable_tags

  has_one_attached :recipe_image


  #難易度評価
  enum difficulty: { ★: 1, ★★: 2, ★★★: 3, ★★★★: 4, ★★★★★: 5}


　# 材料・作り方関連
  has_many :ingredients, dependent: :destroy

  has_many :cookerys, dependent: :destroy
  accepts_nested_attributes_for :cookerys, allow_destroy: true


  validates :title, presence: true, length: { maximum: 50}
  validates :description, presence: true, length: { maximum: 140}

  validate :require_any_ingredients
  validate :require_any_steps

  def require_any_ingredients
    errors.add(:base, "材料は1つ以上登録してください。") if self.ingredients.blank?
  end

  def require_any_steps
    errors.add(:base, "作り方は1つ以上登録してください。") if self.steps.blank?
  end


end
