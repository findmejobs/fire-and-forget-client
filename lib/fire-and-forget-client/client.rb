require 'socket'

module FireAndForget
  class Client
    attr_reader :hostname
    attr_reader :port
    attr_reader :passphrase

    def initialize(hostname = '127.0.0.1', port = 42314, passphrase = '')
      @hostname = hostname
      @port = port
      @passphrase = passphrase
    end

    def record_action(object_type, object_id, object_details, action, action_details)
      json_message = JSON.generate({
        objectType: object_type,
        objectId: object_id,
        objectDetails: object_details,
        action: action,
        actionDetails: action_details
      })
      send_message(json_message)
    end

    private

    def send_message(json_message)
      socket.send(json_message, 0, @hostname, @port)
    end
  end
end
