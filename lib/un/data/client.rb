require 'un/data/host_adaptor'

module UN
  module Data
    UNDATA_USER_KEY_NAME = 'UNDATA_USER_KEY'
    HOST_NAME            = 'undata-api.appspot.com'

    class Client
      def initialize(options = {})
        @host_adpator    = options[:host_adpator] || UN::Data::HostAdaptor.new
        @response_parser = options[:response_parser] || UN::Data::ResponseParser.new

        configure_user_key(options)
      end

      def configure_user_key(options)
        @user_key = ENV[UNDATA_USER_KEY_NAME]

        @user_key = options[:user_key] || @user_key || raise("User key (#{@user_key}) not specified")
      end

      def user_key
        @user_key
      end

      def data_sets
        uri = user_uri :path => '/data/index'

        response = @host_adpator.get(uri)

        @response_parser.parse_data_sets response
      end

      def general_query(name)
        uri = user_uri :path => "/data/query/#{URI.escape(name, Regexp.new('[^#{URI::PATTERN::UNRESERVED}]'))}"

        response = @host_adpator.get(uri)

        @response_parser.parse_query_results response
      end

      def filtered_query(parameters = {})
        path = '/data/query/'
        path << URI.escape(parameters[:name], Regexp.new('[^#{URI::PATTERN::UNRESERVED}]')) || raise('Dataset parameter required for general queries')
        path << '/' << URI.escape(parameters[:year]) unless parameters[:year].nil?
        path << '/' << URI.escape(parameters[:country]) unless parameters[:country].nil?

        uri = user_uri :path => path

        response = @host_adpator.get(uri)

        @response_parser.parse_filter_query response
      end

      def user_uri(options = {})
        URI::HTTP.build :host => HOST_NAME, :path => options[:path], :query => "user_key=#{@user_key}"
      end
    end
  end
end
