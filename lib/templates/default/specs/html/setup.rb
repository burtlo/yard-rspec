def init
  super
  
  @specs = object
  
  sections.push :contexts
end

def contexts
  @contexts = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE.children
  erb(:contexts)
end