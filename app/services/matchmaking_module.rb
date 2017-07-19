module Matchmaking

  def self.make_game(game, teams = {})
    team_1, team_2 = teams[:team_1], teams[:team_2]
    team_1_expected_result = Elo.expected_result({team: team_1, opponent: team_2})
    team_2_expected_result = 1 - team_1_expected_result

    team_1 = Matchmaking.make_games_players(game, team_1, 1, team_1_expected_result)
    team_2 = Matchmaking.make_games_players(game, team_2, 2, team_2_expected_result)

    { team_1: team_1, team_2: team_2 }
  end

  def self.make_teams(pool, team_size = 5)

    pairs = []

    pool.sort { |a, b| a.elo <=> b.elo }

    until pool.length == 0
      pairs << [pool.shift, pool.pop]
    end

    pairs.sort! { |a, b| Elo.elo_average(a) <=> Elo.elo_average(b) }

    team_1, team_2 = [], []
    team_1 << pairs.shift
    team_1 << pairs.pop
    team_2 << pairs.shift
    team_2 << pairs.pop

    team_1.flatten!
    team_2.flatten!
    pairs.flatten!
    
    if Elo.elo_average(team_1) > Elo.elo_average(team_2)
      team_1 << pairs[0]
      team_2 << pairs[1]
    else
      team_1 << pairs[1]
      team_2 << pairs[0]
    end

    { team_1: team_1, team_2: team_2 }
  end


  def self.make_games_players(game, team, team_number, expected_result)
    team.map { |player|
      expected_change = Elo.expected_change(player.elo, expected_result)

      details = {
        team: team_number,
        player_id: player.id,
        game_id: game.id,
        pregame_elo: player.elo,
        expected_loss_change: expected_change[:loss],
        expected_win_change: expected_change[:win]
      }
      GamesPlayer.create(details)
    }

  end
end
