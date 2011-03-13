require 'rexml/document'
require 'ostruct'

module UN
  module Data
    class QueryResult
      def initialize(values)
        @data = {}
        values.each do |key, value|
          @data[key] = value
        end
      end
      
      def [](key)
        @data[key]
      end

      def length
        @data.length
      end
    end
      
    class ResponseParser
      def initialize(options={})
      end

      def check_for_errors(document)
        document.elements.each("/error") do |element|
          raise element.text
        end
      end
      
      def parse_data_sets(data)
        document = REXML::Document.new data

        check_for_errors document
        
        result = []
        document.elements.each("/datasets/dataset") do |element|
          result << OpenStruct.new(:organisation => element.attributes['organisation'],
                                   :category => element.attributes['category'],
                                   :name => element.attributes['name'])
        end
        
        result
      end
      
      
      def parse_query_results(data)
        document = REXML::Document.new data

        check_for_errors document
        
        result = []
        
        document.elements.each("/data/record") do |element|
          
          fields ={}
          
          element.elements.each do |e|
            fields[e.attributes['name']] = e.text
          end
          
          result << QueryResult.new(fields)
        end

        result
      end
    end
  end
end
