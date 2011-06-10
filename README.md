YARD-RSpec: A YARD extension for RSpec 2
=========================================

NOTE: This extension is currently under development. At the current moment,
the plugin is not particularly useful for any individual. Please feel free to 
clone and take a look around.

Currently the project is still in requirements gathering phase. The work up
to this point has been finding and parsing the various components one finds
in an RSpec file and convert them to YARD code objects.

I would love ideas, thoughts, and mock ups of visualization and presentation of
the data and how you would be see the gem serving you.


Synopsis
--------

YARD-Rspec is a YARD extension that processes RSpec test files and includes
them in the documentation output. Tests are often sited as our best 
documentation, so it makes sense to include them there along side the classes,
modules, and methods that they currently test.

YARD-Rspec takes the work started by [@lsegal](https://github.com/lsegal/yard-spec-plugin)
and expands on it to include some small things (e.g. `context` keyword) and
larger things like the full view of the specification file.


Examples
--------

**1. Specs in-line with with [classes and the methods](http://recursivegames.com/rspec/String.html).

**2. Specs displayed with links to their [class, module, and method counterparts](http://recursivegames.com/rspec/rspec/String.html).

**3. Specs [searchable](http://recursivegames.com/rspec/spec_list.html) through a similar interface like class, modules, and files.



Installation
------------

*Build the gem yourself:*

    $ git clone https://github.com/burtlo/yard-rspec
    $ cd yard-rspec
    $ gem build yard-rspec.gemspec
    $ gem install --local yard-rspec-X.X.X.gem

Usage
-----

YARD supports for automatically including gems with the prefix `yard-` 
as a plugin. To enable automatic loading yard-cucumber. 

1. Edit `~/.yard/config` and insert the following line:

    load_plugins: true

2. Run `yardoc`, use the rake task, or run `yard server`, as would [normally](https://github.com/lsegal/yard).

Be sure to update any file patterns so that they do not exclude `feature` 
files. yard-cucumber will even process your step definitions and transforms.

    $ yardoc 'lib/**/*.rb' 'spec/**/*_spec.rb'

An example with the rake task:

    require 'yard'

    YARD::Rake::YardocTask.new do |t|
      t.files   = ['lib/**/*.rb' 'spec/**/*_spec.rb']
      t.options = ['--debug'] # optional arguments
    end


LICENSE
-------

(The MIT License)

Copyright (c) 2011 Franklin Webber

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.