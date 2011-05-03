module YARD::Parser::RSpec
  
  class DocumentationParser < YARD::Parser::Base
    
    def initialize(source, file = '(stdin)')
      @source = source
      @file = file
    end
    
    #
    # Parser the output of Rspec documentation output.
    # 
    def parse
      
      # By default, the first values found in the output are going to be results

      target = nil
      default_target = Result

      #
      # Looking at each line in the source
      # 
      @source.split("\n").each do |line|
        #log.info "line: #{line}"

        # 
        # When the target is nil it means we have just started or
        # we have recently saved a target.
        # 
      
        if target.nil?
          
          if line =~ /^$/
            next
            
          elsif line =~ /^Failures:$/
            #
            # When reaching the line that starts with Failures
            # we assume that the remaining outlined examples are
            # failure examples
            # 
            default_target = Failure
            next
            
          elsif line =~ /^Finished in \d+\.\d+ seconds?$/ || line =~ /^\d+ examples, \d+ failures$/
            
            #
            # Summary statistics are identified by very specific lines
            # 
            target = Summary.new
            
          else
            
            #
            # When we are not switching to failures and not handling
            # summary details we are handling a result or a failure
            #
            target = default_target.new
          end

        end

        if target
          if target.stop?(line)
          
            # 
            # Each target knows when their Result or Failure ends
            # and when that happens, it is time to save the target
            # 

            log.info "Saving #{target.class}" if target.save
          
            # the target is set to nil, so that we will evaluate which target is next
            target = nil

          else
          
            #
            # Have the target parse a line
            #

            target.parse(line)
          end
        end

      end
      
    end
    
    
    #
    # Default YARD Parser methods
    # 
    def tokenize
      
    end
    
    #
    # Default YARD Parser methods
    # 
    def enumerator
      
    end
    
    
    #
    # A Result contains within it a hierachial structure
    # of data of the contexts, sub-contexts, and specifications.
    # 
    # The specifictions themselves can contain if they pass or
    # succeed
    # 
    class Result

      def initialize
        @lines = []
      end

      def parse(line)
        
        result_obj = ResultObject.new
        result_obj.value = line
        
        if child_line?(result_obj)
          
          #
          # When the line is a child line then we need to 
          # promote the last line to a context and assume
          # that this one is a specification
          # 
          
          @lines.last.type = :context
          result_obj.type = :specification
          
        else
          
          # 
          # When it is not a child line then we are looking
          # at the first line or a second (or greater) context
          # within the current context 
          # 
          result_obj.type = :context
          
        end
        
        if result_obj.value =~ /.+\(FAILED - (\d+)\)$/
          result_obj.failure = Regexp.last_match(1)
        end

        @lines << result_obj
        
      end
      
      #
      # If the specifed line is more idented that the
      # previous line it promotes the previous line to
      # a context and the specified line is a child of
      # the last line
      # 
      def child_line?(line)
        if @lines.last
          line.value[/(\s+)/,1].to_s.length > @lines.last.value[/(\s+)/,1].to_s.length
        else
          false
        end
      end

      def stop?(line)
        !!(line =~ /^$/)
      end

      def save
        @lines
      end
      
      class ResultObject
        attr_accessor :value, :type, :failure
      end

    end

    class Failure
      
      def initialize
        @lines = []
        @message = []
      end

      def parse(line)
        
        if @lines.empty?
          if line =~ /^\s+(\d+)\) (.+)$/
            @index = Regexp.last_match(1)
            @value = Regexp.last_match(2)
          end
        elsif @lines.length == 1
          if line =~ /Failure\/Error: (.+)$/
            @failure = Regexp.last_match(1)
          end
        else
          @message << line
        end
        
        
        @lines << line
      end

      def stop?(line)
        !!(line =~/^$/)
      end

      def save
        self
      end
      
    end

    class Summary

      def parse(line)

        if line =~ /^Finished in (\d+\.\d+) seconds/
          @time = Regexp.last_match(1)
        end

      end

      def stop?(line)
        !!(line =~/^(\d+) examples?, (\d+) failures?$/)
      end

      def save
        @time
      end

    end
    
    
    
  end
  
  
  YARD::Parser::SourceParser.register_parser_type :rspec, DocumentationParser, 'rspec'
end