class ChangeColumnToEffect < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :effects, :nutrients
  end
end
