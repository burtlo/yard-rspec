def init
  super
  sections.last.place(:specs).before(:source)
end

def contexts
  log.debug "method_details - Finding Contexts"
  @contexts ||= object[:specifications]
end