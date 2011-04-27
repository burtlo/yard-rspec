
module YARD::CodeObjects
  module RSpec
    
    class Specification < Base
    
      attr_accessor :value, :source, :method
    
      def initialize(namespace,name)
        super(namespace,name)
      end
      
      
    end
    
  end
end