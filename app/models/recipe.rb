class Recipe < ApplicationRecord
  belongs_to :user

  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  has_many :cookerys, dependent: :destroy
  accepts_nested_attributes_for :cookerys, reject_if: :all_blank, allow_destroy: true

  has_many :vegetable_tags, dependent: :destroy
  has_many :vegetables, through: :vegetable_tags

  has_many :myrecipes, dependent: :destroy

  has_many :want_to_make_lists, dependent: :destroy

  has_many :made_lists, dependent: :destroy

  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations, dependent: :destroy

  has_many :reviews, dependent: :destroy

  has_one_attached :recipe_image


  # 難易度評価
  enum difficulty: { ★: 1, ★★: 2, ★★★: 3, ★★★★: 4, ★★★★★: 5 }


  validates :name, presence: true, length: { maximum: 20 }
  validates :summary, length: { maximum: 20 }
  validates :introduction, presence: true, length: { maximum: 200 }

  validate :require_any_ingredients
  validate :require_any_cookerys

  def require_any_ingredients
    errors.add(:base, "材料は1つ以上登録してください") if self.ingredients.blank?
  end

  def require_any_cookerys
    errors.add(:base, "作り方は1つ以上登録してください") if self.cookerys.blank?
  end

  # 現在サインインしているユーザーがお気に入り登録しているかどうか判断するためのメソッド
  # find_byでuser_idとend_user.idが一致するwant_to_make_listsを探し、なければnilを返します。
  def find_want_to_make_list(user)
    want_to_make_lists.find_by(user_id: user.id)
  end

  def find_made_list(user)
    made_lists.find_by(user_id: user.id)
  end


  def self.search(search)
    if search != ""
      Recipe.joins(:user, :vegetables, :ingredients, vegetables: :nutrient, vegetables: [{ nutrients: :effects }])
      .where(["users.account_name LIKE(?) OR vegetables.name LIKE(?) OR summary LIKE(?) OR ingredients.content LIKE(?) OR nutrients.name LIKE(?) OR effects.name LIKE(?)",
      "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Recipe.all
    end
  end
end
