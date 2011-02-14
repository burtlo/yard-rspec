
class RSpecItHandler < YARD::Handlers::Ruby::Base
  handles method_call(:it)
  
  def process
    return if owner.nil?
    obj = P(owner[:spec])
    return if obj.is_a?(Proxy)
    
    (obj[:specifications] ||= []) << {
      name: statement.parameters.first.jump(:string_content).source,
      file: statement.file,
      line: statement.line,
      source: statement.last.last.source.chomp
    }
  end
end