require 'json'
require 'dotenv'
require 'eventmachine'
require 'websocket-eventmachine-client'
Dotenv.load('../../.env')

$messages = []
EM.run do
  $websocket = WebSocket::EventMachine::Client.connect(uri: 'wss://gateway.discord.gg/?v=6&encoding=json')

  $websocket.onopen do

  end

  $websocket.onmessage do |message, type|
    puts "Received message #{message}"
    response = JSON.parse(message)
    $messages << response
    case response["op"]
    when 10
      heartbeat_interval = response["d"]["heartbeat_interval"]
      EventMachine::Timer.new(heartbeat_interval, send_heartbeat)
      sending_payload = {
        op: 2,
        d: {
          token: ENV['DISCORD_API_KEY'],
          properties: {
            :$os => "osx",
            :$browser => "bbmatchmaker",
            :$name => "bbmatchmaker"
          }
        },
      }
      puts sending_payload.to_json
      $websocket.send sending_payload.to_json
    end
  end

  $websocket.onclose do |code, type|
    puts "Disconnected with status code: #{code}"
  end

  def send_heartbeat
    heartbeat_payload = {
      op: 1,
      d: $messages.length > 0 ? $messages.length : null
    }
    $websocket.send heartbeat_payload.to_json
  end

end
