class CreateMadeLists < ActiveRecord::Migration[6.1]
  def change
    create_table :made_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end

    add_index :made_lists, [:user_id, :recipe_id], unique: true
  end
end
