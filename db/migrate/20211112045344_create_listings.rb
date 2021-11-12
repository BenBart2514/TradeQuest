class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.references :hero, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :weapon, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
