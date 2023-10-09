class CreateTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relations do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
