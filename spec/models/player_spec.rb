require 'rails_helper'

RSpec.describe Player, type: :model do

  describe 'Attributes' do
    let(:player) { Player.new }

    it 'can set and get its username' do
      player.username = 'Test'
      expect(player.username).to eq 'Test'
    end

    it 'can set and get its discord_id' do
      player.discord_id = 1080
      expect(player.discord_id).to eq 1080
    end

    it 'can set and get its discord_id' do
      player.elo = 1500
      expect(player.elo).to eq 1500
    end
  end

  describe 'Validations' do
    context 'username' do
      it 'is present' do
        player = Player.create(username: nil, discord_id: 1200, elo: 1000)
        expect(player.errors.full_messages.length).to eq 1
      end

      it 'is unique' do
        Player.create(username: 'Test', discord_id: 1200, elo: 1000)
        player = Player.create(username: 'Test', discord_id: 1300, elo: 1000)
        expect(player.errors.full_messages.length).to eq 1
      end
    end

    context 'discord_id' do
      it 'is present' do
        player = Player.create(username: 'Test', discord_id: nil, elo: 1000)
        expect(player.errors.full_messages.length).to eq 2
      end

      it 'is an integer and greater than 0' do
        player = Player.create(username: 'Test', discord_id: 0.45, elo: 1000)
        expect(player.errors.full_messages.length).to eq 1

        player = Player.create(username: 'Test', discord_id: -1, elo: 1000)
        expect(player.errors.full_messages.length).to eq 1
      end

      it 'is unique' do
        Player.create(username: 'Test', discord_id: 1080, elo: 1050)
        player = Player.create(username: 'Test1', discord_id: 1080, elo: 1000)
        expect(player.errors.full_messages.length).to eq 1
      end
    end

    context 'elo' do
      it 'is an integer and greater than 0' do
        player = Player.create(username: 'Test', discord_id: 1080, elo: 0.45)
        expect(player.errors.full_messages.length).to eq 1

        player = Player.create(username: 'Test', discord_id: 1080, elo: -1)
        expect(player.errors.full_messages.length).to eq 1
      end
    end
  end

  describe 'Associations' do
    context 'QueuedPlayer' do
      it 'has one queue' do
        player = Player.create(username: 'Test', discord_id: 1200, elo: 1000)
        QueuedPlayer.create(player_id: player.id)
        expect(player.queue).to be_a(QueuedPlayer)
      end
    end

    context 'Games Created' do
      it 'has many games_created' do
        player = Player.create(username: 'Test', discord_id: 1200, elo: 1000)
        game = Game.create(creator_id: player.id, game_map: 'Monuments', game_mode: 'Incursion')
        expect(player.games_created).to be_all{ be_a(Game) }
        expect(player.games_created).to include(game)
      end
    end
  end
end
