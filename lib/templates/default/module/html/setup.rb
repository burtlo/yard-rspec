def init
  super
  sections.place(:specs).before(:constant_summary)
end

def specs
  #log.debug "Generating Specs"
  erb(:specs)
end

def contexts
  #log.debug "Finding Contexts"
  @contexts ||= object.children.find_all {|child| child.is_a?(YARD::CodeObjects::RSpec::Context)}
  #log.debug "Contexts: #{@contexts}"
  @contexts
end