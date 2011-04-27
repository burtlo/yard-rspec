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

def link_to_full_specification(context,spec)
  %{<a href='#{url_for(context,spec.unique_id)}'>#{h(spec.value)}</a>}
end