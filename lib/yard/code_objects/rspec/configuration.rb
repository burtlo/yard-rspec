
module YARD::CodeObjects
  module RSpec
    
    class Configuration < NamespaceObject
    
      attr_accessor :name, :value, :configuration
    
      def initialize(namespace,name)
        @configuration = []
        super(namespace,name)
      end

      def unique_id
        "#{file}-#{line}".gsub(/\W/,'-')
      end
      
    end
    
  end
end