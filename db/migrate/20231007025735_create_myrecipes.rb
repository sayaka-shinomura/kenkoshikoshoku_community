class CreateMyrecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :myrecipes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
