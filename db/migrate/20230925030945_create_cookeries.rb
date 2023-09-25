class CreateCookeries < ActiveRecord::Migration[6.1]
  def change
    create_table :cookeries do |t|
      t.references :recipe, foreign_key: true
      t.text :process, null: false
      t.timestamps
    end
  end
end
