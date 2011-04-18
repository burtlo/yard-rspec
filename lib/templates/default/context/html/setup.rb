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
# Tracks the current row to ensure that we are always alternating between even
# and odd row templates.
#
def row
  @row
end