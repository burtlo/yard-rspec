
class RSpecContextHandler < YARD::Handlers::Ruby::Base
  handles method_call(:describe)
  handles method_call(:context)
  
  def process
    # this is the string that:  context Article
    objname = statement.parameters.first.jump(:string_content).source
    
    log.info "Creating Context for text: #{objname}"
    
    if owner.is_a?(YARD::CodeObjects::RootObject)
      context_owner = P(objname).is_a?(Proxy) ? :root : P(objname)
      
      log.info "Context Owner is now: #{context_owner} #{context_owner.class}"
    else
      context_owner = owner
    end
    
    # if the second parameter exists then check to see if it is a method
    if statement.parameters[1]
      src = statement.parameters[1].jump(:string_content).source
      objname += (src[0] == "#" ? "" : "::") + src
    end
    
    log.info "Creating Context with owner #{context_owner.class}"
    
    #
    # When a context is nested in a context, we want to attach that context as
    # a child of the current context. Othwerwise, we want to add it as a top-level
    # context in the Rspec Namespace
    #
    if context_owner.is_a?(YARD::CodeObjects::RSpec::Context)
      obj = YARD::CodeObjects::RSpec::Context.new(context_owner,objname) do |context|
        context.value = objname
        context.owner = context_owner
      end
    else
      obj = YARD::CodeObjects::RSpec::Context.new(YARD::CodeObjects::RSpec::RSPEC_NAMESPACE,objname) do |context|
        context.value = objname
        context.owner = context_owner
      end
    end
    
    
    parse_block(statement.last.last, owner: obj)
  rescue YARD::Handlers::NamespaceMissingError
  end
end