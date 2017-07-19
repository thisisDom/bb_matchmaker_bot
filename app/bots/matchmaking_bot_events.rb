module MatchmakingEvents
  extend Discordrb::EventContainer
 # # Enters Queue
 #  voice_state_update(channel: 'queue') do |event|
 #    queue = event.channel
 #    player = Player.find_by(discord_id: event.user.id).find_or_create do |new_player|
 #      new_player.username = event.user.username
 #    end
 #    if queue.users.length >= 10
 #
 #    end
 #  end
 #  # Exits Queue
 #  voice_state_update(old_channel: 'queue') do |event|
 #    event.user
 #  end
end
