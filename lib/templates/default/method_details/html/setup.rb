def init
  super
  sections.last.place(:specs).before(:source)
end

def contexts
  #log.debug "method_details - Finding Contexts"
  #@contexts ||= object.children.find_all {|child| child.is_a?(YARD::CodeObjects::RSpec::Context)}
  nil
end