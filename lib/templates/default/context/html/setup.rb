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