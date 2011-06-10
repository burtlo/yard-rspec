
class HookHandler < YARD::Handlers::Ruby::Base
  handles method_call(:before), method_call(:after), method_call(:around)
  
  def process
    
    #
    # Find the hook type - before, after, around, :each, :all
    # 
    hook_type = statement.jump(:ident).source
    hook_interval = statement.jump(:arg_paren).first.source
    
    log.debug "Hook Handler [#{hook_type}]"
    
    # When we are within a context then create the hook object and attach it
    # to the current context. Sub-contexts will have to ask their parents
    # for the hooks to gain an understanding of all hooks
    
    
    if owner.is_a?(YARD::CodeObjects::RSpec::Context)
      
      log.debug "Hook [#{hook_type}] being assigned to #{owner}."
      
      hook = YARD::CodeObjects::RSpec::Hook.new(owner,"#{hook_type}-#{hook_interval}") do |h|
        h.name = hook_type
        h.interval = hook_interval
        h.source = statement.source
      end
      
      
    end
    
    
  end
end