class CreateEffects < ActiveRecord::Migration[6.1]
  def change
    create_table :effects do |t|
      t.references :nutrient, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.timestamps
    end
  end
end
