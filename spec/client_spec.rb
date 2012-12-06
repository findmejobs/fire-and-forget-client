require 'fire-and-forget-client'
require 'rspec'
require 'rspec-spies'
require 'json'
require 'socket'

describe 'client' do
  describe '#initialize' do
    it 'should initialize with hostname, port and passphrase parameters' do
      client = FireAndForget::Client.new('thing', 12345, 'something')
      client.hostname.should eq('thing')
      client.port.should eq(12345)
      client.passphrase.should eq('something')
    end

    it "should have a default hostname of 127.0.0.1" do
      client = FireAndForget::Client.new
      client.hostname.should eq('127.0.0.1')
    end

    it "should have a default port" do
      client = FireAndForget::Client.new('thing')
      client.port.should > 0
    end

    it "should allow passphrase to be optional" do
      client = FireAndForget::Client.new('thing', 12345)
      client.passphrase.should eq('')
    end
  end

  describe '#record_action' do
    before(:each) do
      @data = {
        objectType: 'user',
        objectId: 1,
        objectDetails: { something: 'here' },
        action: 'action',
        actionDetails: { somethingelse: 'there' }
      }
    end

    it "converts the incoming to parameters to json and send them to send_message" do
      client = FireAndForget::Client.new()
      client.stub(:send_message).and_return(nil)
      client.record_action(@data[:objectType], @data[:objectId], @data[:objectDetails], @data[:action], @data[:actionDetails])
      client.should have_received(:send_message).with(JSON.generate(@data))
    end

    it "adds the passphrase to the outgoing json" do
      client = FireAndForget::Client.new('127.0.0.1', 42314, '12345')
      client.stub(:send_message).and_return(nil)
      client.record_action(@data[:objectType], @data[:objectId], @data[:objectDetails], @data[:action], @data[:actionDetails])
      data = @data.clone
      data[:passphrase] = '12345'
      client.should have_received(:send_message).with(JSON.generate(data))
    end
  end

  describe '#send_message' do
    before(:each) do
      @data = {
        objectType: 'user',
        objectId: 1,
        objectDetails: { something: 'here' },
        action: 'action',
        actionDetails: { somethingelse: 'there' }
      }
    end

    it "should call socket.send" do
      client = FireAndForget::Client.new('127.0.0.1', 42314)
      client.stub(:send_to_socket).and_return(nil)
      client.record_action(@data[:objectType], @data[:objectId], @data[:objectDetails], @data[:action], @data[:actionDetails])
      client.should have_received(:send_to_socket).with(JSON.generate(@data), 0, '127.0.0.1', 42314)
    end
  end
end
