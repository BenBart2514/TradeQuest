class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|
      t.references :hero, foreign_key: true
      t.references :weapon, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
