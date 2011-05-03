
module YARD::CodeObjects
  module RSpec
    
    class Failure < Base
    
      attr_accessor :message, :parents, :value
    
      def initialize(namespace,name)
        super(namespace,name)
      end
      
    end
    
  end
end