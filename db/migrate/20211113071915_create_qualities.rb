class CreateQualities < ActiveRecord::Migration[6.1]
  def change
    create_table :qualities do |t|
      t.string :name
      t.integer :modifier

      t.timestamps
    end
  end
end
