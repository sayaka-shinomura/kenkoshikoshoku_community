class Recipe < ApplicationRecord

  has_many :ingredients
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  has_many :cookerys
  accepts_nested_attributes_for :cookerys, reject_if: :all_blank, allow_destroy: true

  has_many :vegetable_tags, dependent: :destroy
  has_many :vegetables, through: :vegetable_tags

  has_one_attached :recipe_image


  #難易度評価
  enum difficulty: { ★: 1, ★★: 2, ★★★: 3, ★★★★: 4, ★★★★★: 5}


  validates :name, presence: true, length: { maximum: 50}
  validates :introduction, presence: true, length: { maximum: 140}

  validate :require_any_ingredients
  validate :require_any_steps

  def require_any_ingredients
    errors.add(:base, "材料は1つ以上登録してください。") if self.ingredients.blank?
  end

  def require_any_steps
    errors.add(:base, "作り方は1つ以上登録してください。") if self.steps.blank?
  end


end
