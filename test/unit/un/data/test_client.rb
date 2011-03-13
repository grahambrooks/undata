require 'helper'
require 'un/data/client'

class TestClient < TestCase
  test 'can instanciate a client' do
    UN::Data::Client.new :user_key => ''
  end

  def using_environment(options, &block)
    original = {}
    options.each do |key, value|
      original[key] = ENV[key]
      ENV[key]      = value
    end
    yield
    original.each do |key, value|
      ENV[key] = value
    end
  end

  test 'client requires a user key' do
    using_environment UN::Data::UNDATA_USER_KEY_NAME => nil do
      assert_raises RuntimeError do
        UN::Data::Client.new
      end
    end
  end

  test 'client reads user key from environment if not specified' do

    using_environment UN::Data::UNDATA_USER_KEY_NAME => 'foo' do
      client = UN::Data::Client.new

      assert_equal 'foo', client.user_key
    end
  end

  test 'client requests appropriate URL' do
    mock_host_adaptor = mock('host adaptor')
      
    mock_host_adaptor.expects(:get).with(any_parameters)
      
    client = UN::Data::Client.new :user_key => 'foo', :host_adpator => mock_host_adaptor

    client.data_sets
  end

  test 'user uri include the user key' do
    client = UN::Data::Client.new :user_key => 'foo'

    uri = client.user_uri :path => '/'

    assert_equal 'undata-api.appspot.com', uri.host
    assert_equal '/', uri.path
  end

  test 'client parses response' do
    mock_parser = mock('response parser')
    mock_parser.expects(:parse_data_sets).with('some xml')
    
    client = UN::Data::Client.new :user_key => 'foo', :host_adpator => stub(:get => "some xml"), :response_parser => mock_parser

    client.data_sets
  end
end
