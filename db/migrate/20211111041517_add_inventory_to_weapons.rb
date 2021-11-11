class AddInventoryToWeapons < ActiveRecord::Migration[6.1]
  def change
    add_reference :weapons, :inventory, null: false, foreign_key: true
  end
end
