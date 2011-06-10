
class BehavesLikeHandler < YARD::Handlers::Ruby::Base
  handles method_call(:it_behaves_like)
  
  def process
    
    #
    # Find the shared examples mentioned by the it behaves like method
    # 
    shared_example_name = statement.parameters.first.jump(:string_content).source
    
    shared_example = YARD::Registry.all(:sharedexample).find {|example| example.name.to_s == shared_example_name }

    log.debug "It Behaves Like [#{shared_example_name}]"
    #
    # If a shared example was found and the owner is a context then we should
    # attach this shared exmaple group and/or find all the specifications defined
    # in the shared example group and attach them.
    # 
    
    if shared_example and owner.is_a?(YARD::CodeObjects::RSpec::Context)
      log.debug "Shared Example [#{shared_example_name}]: Added #{shared_example.children.length} children to #{owner}"
      owner.children += shared_example.children
    end
    
  end
end