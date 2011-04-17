
module YARD::CodeObjects
  module RSpec
    
    class Context < NamespaceObject
    
      attr_accessor :value, :specifications, :owner
    
      def initialize(namespace,name)
        @specifications = []
        super(namespace,name)
      end
      
    end
    
  end
end