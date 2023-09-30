class CreateNutrientTags < ActiveRecord::Migration[6.1]
  def change
    create_table :nutrient_tags do |t|
      t.references :vegetable, null: false, foreign_key: true
      t.references :nutrient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
