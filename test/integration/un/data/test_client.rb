require 'helper'

class TestClient < TestCase
  test "user key read from environment" do
    client = UN::Data::Client.new

    assert_equal 32, client.user_key.length
  end
end