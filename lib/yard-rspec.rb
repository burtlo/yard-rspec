require 'rspec'


module RSpecInTheYARD
  VERSION = '0.0.1' unless defined?(RSpecInTheYARD::VERSION)
end

if RUBY19
  require File.dirname(__FILE__) + "/yard/handlers/describe_handler"
  require File.dirname(__FILE__) + "/yard/handlers/it_handler"
end

require File.dirname(__FILE__) + "/yard/handlers/legacy/describe_handler"
require File.dirname(__FILE__) + "/yard/handlers/legacy/it_handler"


# This registered template works for yardoc
YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/templates'

# The following static paths and templates are for yard server
#YARD::Server.register_static_path File.dirname(__FILE__) + "/templates/default/fulldoc/html"
#YARD::Server.register_static_path File.dirname(__FILE__) + "/docserver/default/fulldoc/html"