def init
  super
  sections.last.place(:specs).before(:source)
end

def contexts
  @contexts ||= ( object[:specifications] ? object[:specifications].uniq : nil )
end