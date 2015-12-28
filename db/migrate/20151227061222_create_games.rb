class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :deaths
      t.integer :kills
      t.integer :assists
      t.boolean :win
      t.integer :champion_id
      t.references :summoner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
