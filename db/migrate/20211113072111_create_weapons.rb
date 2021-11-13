class CreateWeapons < ActiveRecord::Migration[6.1]
  def change
    create_table :weapons do |t|
      t.references :hero, foreign_key: true
      t.string :name
      t.references :quality, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true
      t.references :enchant, foreign_key: true
      t.integer :uses
      t.integer :price

      t.timestamps
    end
  end
end
