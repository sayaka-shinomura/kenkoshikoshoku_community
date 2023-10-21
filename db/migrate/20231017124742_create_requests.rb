class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.boolean :confirm, null: true, default: true
      t.text :reply

      t.timestamps
    end
  end
end
