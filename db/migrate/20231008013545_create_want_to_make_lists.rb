class CreateWantToMakeLists < ActiveRecord::Migration[6.1]
  def change
    create_table :want_to_make_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end

    # want_to_make_listsにおいてuser_idとrecipe_idの組み合わせを一意性あるものにする
    add_index :want_to_make_lists, [:user_id, :recipe_id], unique: true
  end
end
