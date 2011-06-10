
module YARD::CodeObjects
  module RSpec
    
    class Hook < Base
    
      attr_accessor :name, :interval, :source
    
      def initialize(namespace,name)
        super(namespace,name)
      end
      
      def unique_id
        "#{file}-#{line}".gsub(/\W/,'-')
      end
      
    end
    
  end
end