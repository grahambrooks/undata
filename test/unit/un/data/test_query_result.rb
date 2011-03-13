require 'helper'
require 'un/data/response_parser'

class TestQueryResult < TestCase
  test 'results contain value' do
    result = UN::Data::QueryResult.new 'key' => 'value'

    assert_equal 'value', result['key']
  end

  test 'results can be represented as text' do
    result = UN::Data::QueryResult.new 'key' => 'value'

    assert_equal "key = value\n", result.to_s
  end
end
