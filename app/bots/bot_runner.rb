require 'discordrb'
require 'dotenv/load'
require_relative 'matchmaking_bot_events'
require_relative 'matchmaking_bot_commands'

bot = Discordrb::Commands::CommandBot.new(token: ENV['DISCORDAPI'], client_id: ENV['DISCORDCLIENT'], prefix: '!')
bot.set_user_permission(ENV['BOTOWNER'].to_i, 9001)


puts "This bot's invite URL is #{bot.invite_url}."
puts 'Click on it to invite it to your server.'

bot.include! MatchmakingCommands
bot.run
