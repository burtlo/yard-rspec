
class LegacyRSpecDescribeHandler < YARD::Handlers::Ruby::Legacy::Base
  MATCH = /\Adescribe\s+(.+?)\s+(do|\{)/
  handles MATCH
  
  def process
    objname = statement.tokens.to_s[MATCH, 1].gsub(/["']/, '')
    obj = {:spec => owner ? (owner[:spec] || "") : ""}
    obj[:spec] += objname
    parse_block :owner => obj
  rescue YARD::Handlers::NamespaceMissingError
  end
end