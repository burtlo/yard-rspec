
class ConfigurationHandler < YARD::Handlers::Ruby::Base
  handles method_call(:configure)
  
  #
  # Capture any RSpec configuration by looking for the method call :configure
  # and then ensuring that we are dealing with the constant RSpec.
  # 
  # @example
  #     RSpec.config do |c|
  #       c.add_setting :custom_setting
  #     end
  # 
  def process
    
    #
    # When the constant calling the configure method is RSpec we want to capture
    # configuration.
    # 
    if statement.jump(:const).source == "RSpec"
      
      owner = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE
      
      config = YARD::CodeObjects::RSpec::Configuration.new(owner,"configuration") do |c|
        c.value = statement.source
      end
      
      # Though configuration is like defined once, we should likely look for an
      # existing configuration node that already exists. (TODO)
      
      block_variable = statement.jump(:block_var).source
      
      # find all the command calls that start with the block variable
      
      statement.jump(:do_block).children.each do |child|
        if child.jump(:block_var).source == block_variable
          config.configuration << child.source
        end
      end
      
    
    end
    
    #parse_block(statement.last.last, owner: shared_examples_object)
  rescue YARD::Handlers::NamespaceMissingError
  end
end