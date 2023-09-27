class ChangeColumnToNutrient < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :nutrients, :effects
  end
end
