def init
  super
  
  # Additional javascript that power the additional menus, collapsing, etc.
  asset("js/rspec.js",file("js/rspec.js",true))
  
  # Generates the specs splash page with the 'specs' template
  serialize(YARD::CodeObjects::RSpec::RSPEC_NAMESPACE)
  
end