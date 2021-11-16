class AddQuestToHeros < ActiveRecord::Migration[6.1]
  def change
    add_reference :heros, :quest, null: false, foreign_key: true
  end
end
