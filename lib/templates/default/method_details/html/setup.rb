def init
  super
  sections.last.place(:specs).before(:source)
end

def contexts
  @contexts ||= ( object[:specifications] ? object[:specifications].uniq : nil )
end

def link_to_full_specification(spec)
  context = spec.parent
  
  until context.parent == YARD::CodeObjects::RSpec::RSPEC_NAMESPACE
    context = context.parent
  end
  
  %{<a href='#{url_for(context,spec.unique_id)}'>#{h(spec.value)}</a>}
end

#
# Return a failure to the specification
# 
def failure(spec)
  
  # Based on the spec we need to see if there is
  # a failure that is associated with it. This can
  # be done by examining each failure through its
  # context tree and the specification through it's
  # context tree. Or we could compare values of the 
  # complete statement
  failures = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE.children.find_all {|child| child.is_a? YARD::CodeObjects::RSpec::Failure }
  
  failures.find do |fail| 
    fail.value == spec.full_name
  end
  
end
