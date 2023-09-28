class CreateEffectTags < ActiveRecord::Migration[6.1]
  def change
    create_table :effect_tags do |t|
      t.references :nutrient, null: false, foreign_key: true
      t.references :effect, null: false, foreign_key: true

      t.timestamps
    end
  end
end
