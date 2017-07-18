class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.integer :discord_id, null: false
      t.string :username, null: false
      t.integer :elo, null: false, default: 1200
      t.timestamps
      t.index :discord_id, unique: true
      t.index :username, unique: true
    end
  end
end
