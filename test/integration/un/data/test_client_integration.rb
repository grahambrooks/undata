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

  test 'query data' do
    client = UN::Data::Client.new

    data_sets = client.data_sets

    result = client.general_query data_sets.first.name

    assert result.length > 0
  end

  test 'filtered query' do
    client = UN::Data::Client.new

    data_sets = client.data_sets
    general = client.general_query data_sets.first.name

    result = client.filtered_query(:name => data_sets[0].name,
                                   :country => general[0]['Country or Area'],
                                   :year => general[0]['Year(s)'])

    assert result.length > 0
  end
end
