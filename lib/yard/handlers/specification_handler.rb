
class RSpecSpecificationHandler < YARD::Handlers::Ruby::Base
  handles method_call(:it)
  
  def process
    # TODO: concerned about the same named specifications
    name = statement.parameters.first.jump(:string_content).source
    #log.info "Creating It with name #{name}"
    
    if owner.is_a?(YARD::CodeObjects::RSpec::Context)
      owner.specifications << YARD::CodeObjects::RSpec::Specification.new(owner,name) do |spec|
        spec.value = name
        spec.source = statement.last.last.source.chomp
        spec.add_file(statement.file,statement.line)
      end
      
    end
    
  end
end