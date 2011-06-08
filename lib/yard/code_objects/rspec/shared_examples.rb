
module YARD::CodeObjects
  module RSpec
    
    class SharedExample < NamespaceObject
    
      attr_accessor :name, :value, :contexts
    
      def initialize(namespace,name)
        @contexts = []
        super(namespace,name)
      end

      def unique_id
        "#{file}-#{line}".gsub(/\W/,'-')
      end
      
    end
    
  end
end