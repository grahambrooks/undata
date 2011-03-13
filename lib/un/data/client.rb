require 'un/data/host_adaptor'

module UN
  module Data
    UNDATA_USER_KEY_NAME = 'UNDATA_USER_KEY'
    HOST_NAME = 'undata-api.appspot.com'
    
    class Client
      def initialize(options = {})
        @host_adpator    = options[:host_adpator] || UN::Data::HostAdaptor.new
        @response_parser = options[:response_parser] || UN::Data::ResponseParser.new
        
        read_environment_settings
        
        @user_key = options[:user_key] || @user_key || raise("User key (#{@user_key}) not specified")
      end

      def read_environment_settings
        @user_key = ENV[UNDATA_USER_KEY_NAME]
      end

      def user_key
        @user_key
      end

      def data_sets
        uri = user_uri :path => '/data/index'
        
        response = @host_adpator.get(uri)

        @response_parser.parse_data_sets response
      end

      def user_uri(options = {})
        URI::HTTP.build :host => HOST_NAME, :path => options[:path], :query => "user_key=#{@user_key}"
      end
    end
  end
end
