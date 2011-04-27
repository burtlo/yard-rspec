def init
  super
  sections.place(:specs).before(:constant_summary)
end

def specs
  erb(:specs)
end

def contexts
  @contexts ||= ( object[:specifications] ? object[:specifications].uniq : nil )
end