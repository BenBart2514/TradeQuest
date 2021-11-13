class CreateEnchants < ActiveRecord::Migration[6.1]
  def change
    create_table :enchants do |t|
      t.string :name
      t.integer :bonus
      t.string :imbue

      t.timestamps
    end
  end
end
