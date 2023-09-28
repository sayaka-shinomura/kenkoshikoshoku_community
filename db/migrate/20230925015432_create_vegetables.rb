class CreateVegetables < ActiveRecord::Migration[6.1]
  def change
    create_table :vegetables do |t|
      t.string :name, null: false
      t.string :seasonal, null: false
      t.text :production_area, null: false
      t.text :keeping, null: false
      t.text :introduction, null: false
      t.string :nutrient, null: false
      t.timestamps
    end
  end
end
