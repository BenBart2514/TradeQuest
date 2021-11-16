class CreateQuests < ActiveRecord::Migration[6.1]
  def change
    create_table :quests do |t|
      t.string :title
      t.string :description
      t.string :element
      t.string :resistance
      t.string :weakness

      t.timestamps
    end
  end
end
