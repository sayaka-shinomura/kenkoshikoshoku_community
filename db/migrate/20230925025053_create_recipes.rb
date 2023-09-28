class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :summary, null: false
      t.text :introduction, null: false
      t.integer :time, null: false
      t.integer :difficulty, null: false
      t.timestamps
    end
  end

end
