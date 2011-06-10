
module YARD::CodeObjects
  module RSpec
    
    class SharedExample < NamespaceObject
    
      attr_accessor :name, :value
    
      def initialize(namespace,name)
        super(namespace,name)
      end
      
      # TODO: specifications
      # TODO: contexts

      def unique_id
        "#{file}-#{line}".gsub(/\W/,'-')
      end
      
    end
    
  end
end