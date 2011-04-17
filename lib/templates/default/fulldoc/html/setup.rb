def init
  super
  
  # Additional javascript that power the additional menus, collapsing, etc.
  asset("js/rspec.js",file("js/rspec.js",true))
  
  # Generates the specs splash page with the 'specs' template
  serialize(YARD::CodeObjects::RSpec::RSPEC_NAMESPACE)
  
  #
  # Generate pages for each of the specs, with the 'spec' template and then
  # generate the page which is the full list of specs
  #
  #@contexts = Registry.all(:context)
  @contexts = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE.children
  # 
  if @contexts
    @contexts.each {|context| serialize(context) }
    generate_full_list @contexts.sort {|x,y| x.value.to_s <=> y.value.to_s }, :spec
  end
  
end


#
# Generate a full_list page of the specified objects with the specified type.
#
def generate_full_list(objects,list_type,friendly_name=nil)
  @items = objects
  @list_type = "#{list_type}s"
  @list_title = "#{friendly_name || list_type.to_s.capitalize} List"
  @list_class = "class"
  asset("#{list_type}_list.html",erb(:full_list))
end

#
# The existing 'Class List' search field would normally contain the RSpec
# Namespace object that has been added. Here we call the class_list method 
# that is contained in the YARD template and we remove the namespace. Returning
# it when we are done. 
#
def class_list(root = Registry.root)
  root.instance_eval { children.delete YARD::CodeObjects::RSpec::RSPEC_NAMESPACE } if root == Registry.root
  out = super(root)
  root.instance_eval { children << YARD::CodeObjects::RSpec::RSPEC_NAMESPACE } if root == Registry.root
  out
end