class CreateVegetableTags < ActiveRecord::Migration[6.1]
  def change
    create_table :vegetable_tags do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :vegetable, null: false, foreign_key: true

      t.timestamps
    end
  end
end
