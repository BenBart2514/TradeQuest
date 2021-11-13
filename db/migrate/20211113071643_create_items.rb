class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :hero, foreign_key: true
      t.string :name
      t.integer :level
      t.string :element
      t.integer :price

      t.timestamps
    end
  end
end
