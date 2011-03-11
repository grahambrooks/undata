

module UN
  module Data
    class Client
      def initialize(options = {})
        @user_key = options[:user_key] || raise("User key not specified")
      end
    end
  end
end
