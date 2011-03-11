require 'un/data/host_adaptor'

module UN
  module Data
    UNDATA_USER_KEY_NAME = 'UNDATA_USER_KEY'
    HOST_NAME = 'undata-api.appspot.com'
    
    class Client
      def initialize(options = {})
        @host_adpator = options[:host_adpator] || UN::Data::HostAdaptor.new
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
        uri = URI::HTTP.build :host => HOST_NAME, :path => '/data/index', :query => "user_key=#{@user_key}"

        @host_adpator.get(uri.to_s)
        []
      end
    end
  end
end
