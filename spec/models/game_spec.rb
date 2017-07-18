require 'rails_helper'

RSpec.describe Game, type: :model do
  before(:all) do
    Player.create(username: 'Test', discord_id: 1200)
  end
  after(:all) do
    Player.destroy_all
  end
  
  describe "Attributes" do
    let(:game) { Game.new }
    it 'can get and set its winner team' do
      game.winning_team = 1
      expect(game.winning_team).to eq 1
    end

    it 'can get and set its game mode' do
      game.winning_team = 1
      expect(game.winning_team).to eq 1
    end

    it 'can get and set its game map' do
      game.winning_team = 1
      expect(game.winning_team).to eq 1
    end
  end

  describe "Validations" do
    context 'winning_team' do
      it 'is an integer and greater than or equal to 0' do
        game = Game.create(creator_id: Player.first.id, winning_team: 0.45, game_map: 'Monuments', game_mode: 'Incursion')
        expect(game.errors.full_messages.length).to eq 1
        game = Game.create(creator_id: Player.first.id, winning_team: -1, game_map: 'Monuments', game_mode: 'Incursion')
        expect(game.errors.full_messages.length).to eq 1
      end
    end

    context 'game_mode' do
      it 'is present' do
        game = Game.create(creator_id: Player.first.id, game_map: 'Monuments')
        expect(game.errors.full_messages.length).to eq 1
      end
    end

    context 'game_map' do
      it 'is present' do
        game = Game.create(creator_id: Player.first.id, game_mode: 'incursion')
        expect(game.errors.full_messages.length).to eq 1
      end
    end
  end

  describe "Associations" do
    context 'creator' do
      it 'belongs to a creator' do
        game = Game.create(creator_id: Player.first.id, game_map: 'Monuments', game_mode: 'Incursion')
        expect(game.creator).to be_a(Player)
        expect(game.creator).to eq Player.first
      end
    end
  end
end
