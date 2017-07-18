require 'rails_helper'

RSpec.describe QueuedPlayer, type: :model do
  before(:all) do
    Player.create(username: 'Test', discord_id: 1200)
  end
  after(:all) do
    Player.destroy_all
  end
  
  describe 'Associations' do
    context 'Player' do
      it 'belongs to a player' do
        queued_player = QueuedPlayer.create(player_id: Player.first.id)
        expect(queued_player.player).to be_a(Player)
        expect(queued_player.player).to eq(Player.first)
      end
    end
  end
end
