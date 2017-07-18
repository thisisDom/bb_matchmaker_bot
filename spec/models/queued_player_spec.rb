require 'rails_helper'

RSpec.describe QueuedPlayer, type: :model do
  describe 'Associations' do
    context 'Player' do
      it 'belongs to a player' do
        player_id = Player.create(username: 'Test', discord_id: 1200, elo: 1000).id
        queued_player = QueuedPlayer.create(player_id: player_id)
        expect(queued_player.player).to be_a(Player)
      end
    end
  end
end
