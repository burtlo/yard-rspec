
class SharedContextHandler < YARD::Handlers::Ruby::Base
  handles method_call(:shared_context)
  
  #
  # When coming across a shared context we want to capture source code, so that
  # when a context explicitly declares a `used_context` or implicity matches the
  # addtional parameters of metadata, then we can tie the shared context to
  # the context
  # 
  def process
    
    #
    # Capture the name of the shared context, which is the first string parameter
    # 
    # @example 'context Article'
    #   statement.parameters.first.jump(:string_content).source # => 'Article'
    #
    name = statement.parameters.first.jump(:string_content).source

    name = "EMPTY STRING" if name.nil? || name == ""

    log.debug "Creating [Shared Context]: #{name}"
    
    #
    # All remaining parameters are metadata that could be matched as well. Look
    # at each of the parameters until you come to a parameter that solely reports
    # false.
    # 
    parameter_index = 1
    metadata = []
    
    until (parameter = statement.parameters[parameter_index]) == false
      metadata << parameter.source 
      parameter_index += 1
    end
    
    #
    # The shared context will be a child of the RSpec Namespace
    # 
    
    shared_context_owner = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE
    
    #
    # Create the shared context object as a child of the Rspec Namespace
    #
    shared_context_object = YARD::CodeObjects::RSpec::SharedContext.new(shared_context_owner,name) do |context|
      context.value = name
      context.add_file(statement.file,statement.line)
      context.metadata = metadata
    end
    
    parse_block(statement.last.last, owner: shared_context_object)
  rescue YARD::Handlers::NamespaceMissingError
  end
end