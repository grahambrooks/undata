require 'helper'

class TestHostAdaptor < TestCase
  test 'get returns response body' do
    adaptor = UN::Data::HostAdaptor.new
    
    uri = URI::HTTP.build :host => 'www.google.com', :path => '/'

    
    data = adaptor.get uri

    assert_match /<!doctype html>/, data
  end
end
