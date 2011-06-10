
class SharedExamplesHandler < YARD::Handlers::Ruby::Base
  handles method_call(:shared_examples)
  
  #
  # When coming across shared examples generate a SharedExample object
  # to represent these shared examples.
  # 
  # * Shared Examples have a name that describes them.
  # * They can also optionally have some context given to them by a context that
  #     is using them (TODO)
  # * They can also accept parameters (TODO) 
  # 
  def process
    #
    # Capture the name of the shared examples, which is the first string parameter
    # 
    # @example
    # 
    #     shared_examples "a collection" do # => "a collection"
    # 
    name = statement.parameters.first.jump(:string_content).source

    name = "EMPTY STRING" if name.nil? || name == ""

    log.debug "Creating [Shared Example]: #{name}"

    #
    # The shared context will be a child of the RSpec Namespace
    # 
    
    shared_examples_owner = YARD::CodeObjects::RSpec::RSPEC_NAMESPACE
    
    #
    # Create the shared context object as a child of the Rspec Namespace
    #
    shared_examples_object = YARD::CodeObjects::RSpec::SharedExample.new(shared_examples_owner,name) do |examples|
      examples.value = name
      examples.add_file(statement.file,statement.line)
    end
    
    parse_block(statement.last.last, owner: shared_examples_object)
  rescue YARD::Handlers::NamespaceMissingError
  end
end