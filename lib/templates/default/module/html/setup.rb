def init
  super
  sections.place(:specs).before(:constant_summary)
end