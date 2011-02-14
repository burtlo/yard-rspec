require 'YARD'
require File.dirname(__FILE__) + "/lib/yard-rspec"

module RSpecInTheYARD
  extend self
  
  def show_version_changes(version)
    date = ""
    changes = []  
    grab_changes = false

    File.open("#{File.dirname(__FILE__)}/History.txt",'r') do |file|
      while (line = file.gets) do

        if line =~ /^===\s*#{version.gsub('.','\.')}\s*\/\s*(.+)\s*$/
          grab_changes = true
          date = $1.strip
        elsif line =~ /^===\s*.+$/
          grab_changes = false
        elsif grab_changes
          changes = changes << line
        end

      end
    end

    { :date => date, :changes => changes }
  end
end

Gem::Specification.new do |s|
  s.name        = 'yard-rspec'
  s.version     = ::RSpecInTheYARD::VERSION
  s.authors     = ["Franklin Webber"]
  s.description = %{ 
    YARD-Rspec is a YARD extension that processes RSpec tests and provides documentation 
    interface that allows you easily view and investigate the test suite. }
  s.summary     = "RSpec in YARD"
  s.email       = 'franklin.webber@gmail.com'
  s.homepage    = "http://github.com/burtlo/yard-rspec"

  s.platform    = Gem::Platform::RUBY
  
  changes = RSpecInTheYARD.show_version_changes(::RSpecInTheYARD::VERSION)
  
  s.post_install_message = %{
(##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##)

  Thank you for installing yard-rspec #{::RSpecInTheYARD::VERSION} / #{changes[:date]}.
  
  Changes:
  #{changes[:changes].collect{|change| "  #{change}"}.join("")}
(##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##) (##)

}

  s.add_dependency 'rspec', '~> 2.0'
  s.add_dependency 'yard', '>= 0.6.3'
  
  s.rubygems_version   = "1.3.7"
  s.files            = `git ls-files`.split("\n")
  s.extra_rdoc_files = ["README.md", "History.txt"]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"
end
