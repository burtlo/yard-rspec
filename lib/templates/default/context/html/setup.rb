def init
  super
  
  log.info "Context HTML Template"
  @context = object
    
  sections.push :describe
end

def describe
  erb(:describe)
end

def context
  @context
end

def specification
  @specification
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

#
# Tracks the current row to ensure that we are always alternating between even
# and odd row templates.
#
def row
  @row
end

# If the context is linked to code object (e.g. class, module, method) then
# create a link back to that object, otherwise just display the value of the
# context
def link_to_code_object(context)
  if context.paired_to_code_object
    linkify context.paired_to_code_object, h(context.value)
  else
    h(context.value)
  end
end