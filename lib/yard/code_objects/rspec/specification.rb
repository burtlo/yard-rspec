
module YARD::CodeObjects
  module RSpec
    
    class Specification < Base
    
      attr_accessor :value, :source
    
      def initialize(namespace,name)
        super(namespace,name)
      end
      
      def unique_id
        "#{file}-#{line}".gsub(/\W/,'-')
      end
      
      def full_name
        
        spec_parent = parent
        
        realized_full_name = value
        while spec_parent.is_a?(Context)
          realized_full_name = spec_parent.value + (realized_full_name[0] == '#' ? '' : ' ') + realized_full_name
          spec_parent = spec_parent.parent
        end
        
        realized_full_name
      end
      
    end
    
  end
end