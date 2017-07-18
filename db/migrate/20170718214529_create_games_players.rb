class CreateGamesPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :games_players do |t|
      t.belongs_to :player, index: true
      t.belongs_to :game, index: true
      t.integer :team, null: false
      t.integer :pregame_elo, null: false
      t.integer :expected_win_change, null: false
      t.integer :expected_loss_change, null: false
      t.timestamps
    end
  end
end
