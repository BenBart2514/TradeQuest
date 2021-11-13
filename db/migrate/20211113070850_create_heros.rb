class CreateHeros < ActiveRecord::Migration[6.1]
  def change
    create_table :heros do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :life
      t.integer :gold
      t.integer :renown

      t.timestamps
    end
  end
end
