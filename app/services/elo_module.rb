module Elo

  def self.elo_average(team = [])
    total = team.reduce(0) { |sum, player| sum + player.elo }
    total.to_f / team.length
  end

  def self.expected_result(game = {})
    q_team = 10.00 ** (elo_average(game[:team]) / 400)
    q_opponent = 10.00 ** (elo_average(game[:opponent]) / 400)
    q_team / (q_opponent + q_team)
  end

  def self.expected_change(rating, expected_team_result)
    k = 32.00
    expected_loss = rating + (k * (0 - expected_team_result)).round
    expected_win = rating + (k * (1 - expected_team_result)).round
    { win: expected_win, loss: expected_loss}
  end

  def self.update_elos(game = {})
    game[:winning_team].each { |game_player|
      game_player.player.update({elo: game_player.expected_win_change})
    }
    game[:losing_team].each { |game_player|
      game_player.player.update({elo: game_player.expected_loss_change})
    }
  end

end
