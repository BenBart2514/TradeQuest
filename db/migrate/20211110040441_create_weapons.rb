class CreateWeapons < ActiveRecord::Migration[6.1]
  def change
    create_table :weapons do |t|
      t.string :name
      t.references :quality, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true
      t.references :enchant, null: false, foreign_key: true
      t.integer :uses, default: 0

      t.timestamps
    end
  end
end
