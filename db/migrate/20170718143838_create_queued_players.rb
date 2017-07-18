class CreateQueuedPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :queued_players do |t|
      t.belongs_to :player, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
