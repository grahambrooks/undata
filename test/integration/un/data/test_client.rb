require 'helper'
require 'un/data/client'

class TestClient < TestCase
  test "user key read from environment" do
    client = UN::Data::Client.new

    assert_equal 32, client.user_key.length
  end

  test 'retrieve datasets' do
    client = UN::Data::Client.new

    assert client.data_sets.length > 1
  end
end
