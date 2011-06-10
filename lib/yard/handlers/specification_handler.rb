
class RSpecSpecificationHandler < YARD::Handlers::Ruby::Base
  handles method_call(:it)
  
  def process
    # The statements first child is the "it"
    # The second child is the name of the specification, when that is not present
    #     then we are likely dealing with an anonymous inline spec.
    # The third child is the block of the specification

    
    # TODO: concerned about the same named specifications
    
    name = statement.children[1].source
    
    # When the name of the specification is an empty string we will use the
    # contents of block to represent what the specification is attempting to 
    # describe about the context

    name = statement.last.last.source.chomp if name == ""
    
    if owner.is_a?(YARD::CodeObjects::RSpec::Context) or
       owner.is_a?(YARD::CodeObjects::RSpec::SharedExample)
       
      owner.specifications << YARD::CodeObjects::RSpec::Specification.new(owner,name) do |spec|
        spec.value = name
        spec.source = statement.last.last.source.chomp
        spec.add_file(statement.file,statement.line)
      end
      
    end
    
  end
end