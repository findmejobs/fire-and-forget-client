require 'fire-and-forget-client'

client = FireAndForget::Client.new
client.record_action('user', 1, '', 'test', '')
