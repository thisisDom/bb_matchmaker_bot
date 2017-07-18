require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { Player.new }

  describe 'Attributes' do
    describe 'username' do
      context 'reading/writing' do
        it 'can set and get its username' do
          player.username = 'Test'
          expect(player.username).to eq 'Test'
        end
      end

      context 'validations' do
        it 'is present' do
          player = Player.create(username: nil, discord_id: nil, elo: 1000)
          expect(player.errors.full_messages.length).to eq 1
        end

        it 'is unique' do
          Player.create(username: 'Test', discord_id: nil, elo: 1000)
          player = Player.create(username: 'Test', discord_id: nil, elo: 1000)
          expect(player.errors.full_messages.length).to eq 1
        end
      end
    end

    describe 'discord_id' do
      context 'reading/writing' do
        player.discord_id = 1080
        expect(discord_id).to eq 1080
      end

      context 'validations' do
        it 'is present' do
          player = Player.create(username: 'Test', discord_id: nil, elo: 1000)
          expect(player.errors.full_messages.length).to eq 1
        end

        it 'is an integer' do
          player = Player.create(username: 'Test', discord_id: .45, elo: 1000)
          expect(player.errors.full_messages.length).to eq 1
        end

        it 'is unique' do
          Player.create(username: 'Test', discord_id: 1080, elo: 1050)
          player = Player.create(username: 'Test', discord_id: 1080, elo: 1000)
          expect(player.errors.full_messages.length).to eq 1
        end
      end
    end

    describe 'elo' do
      context 'reading/writing' do
        player.elo = 1500
        expect(elo).to eq 1500
      end

      context 'validations' do
        it 'is an integer and greater than 0' do
          player = Player.create(username: 'Test', discord_id: 1080, elo: .45)
          expect(player.errors.full_messages.length).to eq 1

          player = Player.create(username: 'Test', discord_id: 1080, elo: -1)
          expect(player.errors.full_messages.length).to eq 1
        end
      end
    end

  end
end
