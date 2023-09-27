class AddEffectToNutrients < ActiveRecord::Migration[6.1]
  def change
    add_column :nutrients, :effect, :string
  end
end
