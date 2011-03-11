

module UN
  module Data
    UNDATA_USER_KEY_NAME = 'UNDATA_USER_KEY'
    
    class Client
      def initialize(options = {})
        read_environment_settings
        
        @user_key = @user_key || options[:user_key] || raise("User key (#{@user_key}) not specified")
      end

      def read_environment_settings
        @user_key = ENV[UNDATA_USER_KEY_NAME]
      end

      def user_key
        @user_key
      end

      def data_sets
        []
      end
    end
  end
end
