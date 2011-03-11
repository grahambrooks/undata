
require 'helper'
require 'un/data/client'

class TestClient < TestCase
  test 'can instanciate a client' do
    UN::Data::Client.new :user_key => ''
  end

  test 'client requires a user key'do
    assert_raises RuntimeError do
      UN::Data::Client.new
    end
  end
end

