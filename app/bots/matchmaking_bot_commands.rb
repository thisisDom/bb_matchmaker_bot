module MatchmakingCommands
  extend Discordrb::Commands::CommandContainer

  command :random_teams, { required_permissions: [:administrator] } do |event|
    queue = event.server.channels.find { |channel| channel.name.downcase == 'queue' }
    team_1_channel = event.server.channels.find { |channel| channel.name.downcase == 'team-1' }
    team_2_channel = event.server.channels.find { |channel| channel.name.downcase == 'team-2' }
    players = queue.users
    pool_a = players.slice!(0,5)
    pool_b = players

    pool_a.each do |player|
      event.server.move(player, team_2_channel)
    end
    pool_b.each do |player|
      event.server.move(player, team_2_channel)
    end

    event.respond '#{queue}'
  end

  command :matchmaking, { permission_level: 9000 } do |event, mode, map|
    queue = event.server.channels.find { |channel| channel.name.downcase == 'queue' }
    queued_players = queue.users

    players = queued_players.map do |queued_player|
      Player.find_or_create_by(discord_id: queued_player.id) do |player|
        player.username = queued_player.username
      end
    end

    if queued_players.length < 10
      event.respond 'Not Enough Players In Queue'
      return false
    end

    player_pool = queued_players.shuffle.slice(0, 10)

    game = Game.create(creator_id: 1, game_mode: mode, game_map: map)

    teams = Matchmaking.make_game(game, Matchmaking.make_teams(player_pool))

    team_1_channel = event.server.create_channel("game\##{game.id}-team-1", 2)
    team_2_channel = event.server.create_channel("game\##{game.id}-team-2", 2)

    teams[:team_1].each do |games_player|
      event.server.move(event.server.member(games_player.player.discord_id), team_1_channel)
    end
    teams[:team_2].each do |games_player|
      event.server.move(event.server.member(games_player.player.discord_id), team_2_channel)
    end
  end

  command :game_result, { permission_level: 9000 } do |event, game, winning_team|
    game = Game.find_by(id: game.to_i )
    return "Game Not Found" unless game
    return "Game Results Entered" if game.winning_team = 0

    game.update(winning_team: winning_team.to_i)


    winning_team_members = GamesPlayer.where(["game_id = ? AND team = ?", game.id, winning_team])
    losing_team_members = GamesPlayer.where(["game_id = ? AND team != ?", game.id, winning_team])

    Elo.update_elos({ winning_team: winning_team_members, losing_team: losing_team_members })

    lobby = event.server.channels.find { |channel| channel.name.downcase == 'general' }

    team_1_channel = event.server.channels.find { |channel| channel.name.downcase == "game\##{game.id}-team-1" }
    team_1_channel.users.each { |member| event.server.move(member, lobby) }
    team_2_channel = event.server.channels.find { |channel| channel.name.downcase == "game\##{game.id}-team-2" }
    team_2_channel.users.each { |member| event.server.move(member, lobby) }
  end
end
