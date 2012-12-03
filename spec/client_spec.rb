require 'fire-and-forget-client'
require 'rspec'

describe 'client' do
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
