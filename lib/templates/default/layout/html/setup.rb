def init
  super
end

def yard_default_stylesheets
  [ 'css/style.css', 'css/common.css' ]
end

def yard_default_javascripts
  [ 'js/jquery.js','js/app.js' ]
end

def yard_default_search_fields
  [ { :type => 'class', :title => 'Classes', :search_title => 'Class List' },
    { :type => 'method', :title => 'Methods', :search_title => 'Method List' }, 
    { :type => 'file', :title => 'Files', :search_title => 'File List' } ]
end

def stylesheets
  css = super rescue yard_default_stylesheets
  css + [ 'css/rspec.css' ]
end

def javascripts
  js = super rescue yard_default_javascripts
  js + [ 'js/rspec.js' ]
end

def search_fields
  fields = super rescue yard_default_search_fields
  [ { :type => 'spec', :title => 'Specs', :search_title => 'Specs' } ] + fields
end