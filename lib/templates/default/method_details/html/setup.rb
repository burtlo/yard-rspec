def init
  super
  sections.last.place(:specs).before(:source)
end

def contexts
  @contexts ||= ( object[:specifications] ? object[:specifications].uniq : nil )
end

def link_to_full_specification(spec)
  context = spec.parent
  
  until context.parent == YARD::CodeObjects::RSpec::RSPEC_NAMESPACE
    context = context.parent
  end
  
  %{<a href='#{url_for(context,spec.unique_id)}'>#{h(spec.value)}}
end