require 'helper'
require 'un/data/response_parser'

class TestResponseParser < TestCase

  test 'can instantiate a parser' do
    UN::Data::ResponseParser.new
  end

  test 'parses basic datasets' do
    single_entry = <<EOD
<datasets>
  <dataset organisation='IMF' category='International Financial statistics' name='BOP: capital account credit, US$'  />
</datasets>
EOD
    parser = UN::Data::ResponseParser.new

    data = parser.parse_data_sets single_entry

    assert_equal 1, data.length
    assert_equal 'IMF', data[0].organisation
    assert_equal 'International Financial statistics', data[0].category
    assert_equal 'BOP: capital account credit, US$', data[0].name
  end

  test "parses general query results" do
    query_result = <<EOD
<data>
   <record>
     <field name="Country or Area">Afghanistan</field>
     <field name="Year(s)">2001</field>
     <field name="Value">151</field>
   </record>
</data>
EOD
    parser = UN::Data::ResponseParser.new

    data = parser.parse_query_results query_result

    assert_equal 1, data.length
    assert_equal 3, data[0].length
    assert_equal 'Afghanistan', data[0]["Country or Area"]
    assert_equal '2001', data[0]['Year(s)']
    assert_equal '151', data[0]['Value']
  end
end
