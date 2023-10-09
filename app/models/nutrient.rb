class Nutrient < ApplicationRecord

  has_many :effect_tags, dependent: :destroy
  has_many :effects, through: :effect_tags

  has_many :nutrient_tags, dependent: :destroy
  has_many :vegetables, through: :nutrient_tags, dependent: :destroy

  def self.search_for(content, method)
    if method == 'perfect'
      Nutrient.where(name: content)
    elsif method == 'forward'
      Nutrient.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Nutrient.where('name LIKE ?', '%' + content)
    else
      Nutrient.where('name LIKE ?', '%' + content + '%')
    end
  end

end
