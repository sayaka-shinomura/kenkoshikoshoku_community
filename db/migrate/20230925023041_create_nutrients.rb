class CreateNutrients < ActiveRecord::Migration[6.1]
  def change
    create_table :nutrients do |t|
      t.references :vegetable, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.timestamps
    end
  end
end
