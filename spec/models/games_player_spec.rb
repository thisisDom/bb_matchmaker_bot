require 'rails_helper'

RSpec.describe GamesPlayer, type: :model do
  before(:all) do
    Player.create(username: 'Test', discord_id: 1200)
    Game.create(creator_id: Player.first.id, winning_team: 0, game_map: 'Monuments', game_mode: 'Incursion')
  end
  describe 'Attributes' do
    let(:games_player) { GamesPlayer.new }
    it 'can get and set its team' do
      games_player.team = 1
      expect(games_player.team).to eq 1
    end

    it 'can get and set its pregame_elo' do
      games_player.pregame_elo = 1600
      expect(games_player.pregame_elo).to eq 1600
    end

    it 'can get or set its expected_gain_change' do
      games_player.expected_win_change = 1625
      expect(games_player.expected_win_change).to eq 1625
    end

    it 'can get or set its expected_loss_change' do
      games_player.expected_loss_change = 1575
      expect(games_player.expected_loss_change).to eq 1575
    end
  end

  describe 'Validations' do
    context 'team' do
      it 'is an integer and greater than or equal to 0' do
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 0.5, pregame_elo: Player.first.elo, expected_win_change: (Player.first.elo + 25), expected_loss_change: (Player.first.elo - 25))
        expect(games_player.errors.full_messages.length).to eq 1
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: -1, pregame_elo: Player.first.elo, expected_win_change: (Player.first.elo + 25), expected_loss_change: (Player.first.elo - 25))
        expect(games_player.errors.full_messages.length).to eq 1
      end
    end

    context 'pregame_elo' do
      it 'is an integer and greater than or equal to 0' do
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: 0.5, expected_win_change: (Player.first.elo + 25), expected_loss_change: (Player.first.elo - 25))
        expect(games_player.errors.full_messages.length).to eq 1
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: -1, expected_win_change: (Player.first.elo + 25), expected_loss_change: (Player.first.elo - 25))
        expect(games_player.errors.full_messages.length).to eq 1
      end
    end

    context 'expected_win_change' do
      it 'is an integer and greater than or equal to 0' do
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: Player.first.elo, expected_win_change: 0.5, expected_loss_change: (Player.first.elo - 25))
        expect(games_player.errors.full_messages.length).to eq 1
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: Player.first.elo, expected_win_change: -1, expected_loss_change: (Player.first.elo - 25))
        expect(games_player.errors.full_messages.length).to eq 1
      end
    end

    context 'expected_loss_change' do
      it 'is an integer and greater than or equal to 0' do
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: Player.first.elo, expected_loss_change: 0.5, expected_win_change: (Player.first.elo + 25))
        expect(games_player.errors.full_messages.length).to eq 1
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: Player.first.elo, expected_loss_change: -1, expected_win_change: (Player.first.elo + 25))
        expect(games_player.errors.full_messages.length).to eq 1
      end
    end
  end

  describe 'Associations' do
    context 'game' do
      it 'belongs to a game' do
        games_player = GamesPlayer.create(game_id: Game.first.id, player_id: Player.first.id, team: 1, pregame_elo: Player.first.elo, expected_win_change: (Player.first.elo + 25), expected_loss_change: (Player.first.elo - 25))
        expect(games_player.player).to be_a(Player)
        expect(games_player.player).to eq Player.first
        expect(games_player.game).to be_a(Game)
        expect(games_player.game).to eq Game.first
      end
    end

  end

end
