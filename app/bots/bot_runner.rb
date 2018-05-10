require 'discordrb'
require 'dotenv'
require_relative 'matchmaking_bot_commands'

Dotenv.load('../../.env')

bot = Discordrb::Commands::CommandBot.new(token: ENV['DISCORD_API_KEY'], client_id: ENV['DISCORD_CLIENT_ID'], prefix: '!')
bot.set_user_permission(ENV['BOTOWNER_ID'].to_i, 9001)


puts "This bot's invite URL is #{bot.invite_url}."
puts 'Click on it to invite it to your server.'

bot.include! MatchmakingCommands
bot.run
