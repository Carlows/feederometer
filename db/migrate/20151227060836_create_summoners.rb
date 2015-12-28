class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      t.string :name
      t.integer :icon_id

      t.timestamps null: false
    end
    add_index :summoners, :name, unique: true
  end
end
