
module YARD::CodeObjects
  module RSpec
    
    class SharedContext < NamespaceObject
    
      attr_accessor :name, :metadata, :value, :contexts
    
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