def init
  super
  
  # Additional javascript that power the additional menus, collapsing, etc.
  asset("js/rspec.js",file("js/rspec.js",true))
  
end