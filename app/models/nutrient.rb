class Nutrient < ApplicationRecord

  belongs_to :vegetable, optional: true
  has_many :effects

  before_save do
  self.effects_ids.gsub!(/[\[\]\"]/, "") if attribute_present?("effects_ids")
  end

end
