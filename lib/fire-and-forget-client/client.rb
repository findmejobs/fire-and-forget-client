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
      json_message = {
        objectType: object_type,
        objectId: object_id,
        objectDetails: object_details,
        action: action,
        actionDetails: action_details
      }
      json_message[:passphrase] = @passphrase unless @passphrase.empty?
      send_message(JSON.generate(json_message))
    end

    private

    def send_message(json_message)
      send_to_socket(json_message, 0, @hostname, @port)
    end

    def send_to_socket(json_message, num, hostname, port)
      socket.send(json_message, num, hostname, port)
    end

    def socket
      @openedSocket ||= UDPSocket.new
    end
  end
end
