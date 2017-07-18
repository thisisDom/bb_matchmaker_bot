class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :creator_id, index: true
      t.integer :winning_team, default: 0
      t.string :game_map, null: false
      t.string :game_mode, null: false
      t.timestamps
    end
  end
end
