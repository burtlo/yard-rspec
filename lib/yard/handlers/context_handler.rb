
class RSpecContextHandler < YARD::Handlers::Ruby::Base
  handles method_call(:describe)
  handles method_call(:context)
  
  def process
    #
    # Find the first parameter and get the string contents
    # 
    # @example 'context Article'
    #   statement.parameters.first.jump(:string_content).source # => 'Article'
    #
    name = statement.parameters.first.jump(:string_content).source

    name = "EMPTY STRING" if name.nil? || name == ""

    log.debug "Creating Context for text: #{name}"
    
    #
    # If we are currently at root then we consider this a top level
    # context that we will add to the RSpec Namespace, otherwise we will
    # assume that this context is sub-context contained within another context
    # and assign that owner
    #
    if owner.is_a? YARD::CodeObjects::RootObject
      context_owner = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE
    else
      context_owner = owner
    end
    
    #
    # Create a context object as a child of the context_owner with the name
    #
    context_object = YARD::CodeObjects::RSpec::Context.new(context_owner,name) do |context|
      context.value = name
      context.owner = context_owner
      context.add_file(statement.file,statement.line)
    end

    
    if owner.is_a? YARD::CodeObjects::RootObject
      
      # TODO: the name itself, at any level could be checked if we thought
      # that it was a Class or Module. For now we will assume that it is only
      # top level contexts
      
      # Root level contexts also have their text evaluated against the 
      # repository of items to find if an object exists with the same name
      context_belongs_to_object = P(name).is_a?(Proxy) ?  nil : P(name)
      
      if context_belongs_to_object
        context_belongs_to_object = [context_belongs_to_object] unless context_belongs_to_object.is_a?(Enumerable)
 
        
        context_belongs_to_object.each do |parent_object|
          # when it does not exist then we want to add the context to the parent object
          log.debug "Class: [#{parent_object.name}] assigned the context #{name}"
          (parent_object[:specifications] ||= []) << context_object
          context_object.paired_to_code_object = parent_object
          
        end
        
      end
      
    else
      
      # When composed within a context, ask that owner for the name of it's
      # content object. When one exists, then check to see if the name of
      # context here is one that matches a method pattern.
      
      parent_context_belongs_to_object = P(context_owner.value).is_a?(Proxy) ?  nil : P(context_owner.value)
      
      # When we have a parent context object and the name looks like a method
      # then we have a method match
      if parent_context_belongs_to_object and name =~ /^#(.+)$/
        
        parent_context_belongs_to_object = [parent_context_belongs_to_object] unless parent_context_belongs_to_object.is_a?(Enumerable)
        
        parent_context_belongs_to_object.each do |parent_object|
        
          #log.info "Parent Context belongs to object #{parent_object.name}"
          context_belongs_to_method = parent_object.children.find_all {|child| child.is_a?(MethodObject) }.find {|method| method.name == Regexp.last_match(1).to_sym }
        
          # We want to add a reference of the context to the method if one exists
          if context_belongs_to_method
            
            log.debug "Method: [#{context_belongs_to_method.parent.name}##{context_belongs_to_method.name}] assigned the context #{name}"
            (context_belongs_to_method[:specifications] ||= []) << context_object
            context_object.paired_to_code_object = context_belongs_to_method

          end
          
        end
        
      end
      
    end
    
    # TODO: Handle additional parameters
    # Often times the second parameter will be the method parameter and that
    # should be examined and compared as we have done above when it is present
    if statement.parameters[1]
      src = statement.parameters[1].jump(:string_content).source
      name += (src[0] == "#" ? "" : "::") + src
    end
    
    
    parse_block(statement.last.last, owner: context_object)
  rescue YARD::Handlers::NamespaceMissingError
  end
end