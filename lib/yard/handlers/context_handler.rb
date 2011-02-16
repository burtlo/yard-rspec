
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
    obj = YARD::CodeObjects::RSpec::Context.new(context_owner,objname)
    
    log.info "Owner now has a context child #{context_owner.children.find_all{|s| s.is_a?(YARD::CodeObjects::RSpec::Context) }}"
    
    parse_block(statement.last.last, owner: obj)
  rescue YARD::Handlers::NamespaceMissingError
  end
end