#!/bin/env ruby
require 'zed/spritesheet'

# The constructor can take a single parameter for the base name of the files
# The class expect an XML file named `basename.xml`
# The base name argument can specify a path (e.g. 'assets/sprites/city')
# The base name will be used when calling #export

ss = ZED::Spritesheet.fromXML 'citydetails'

puts ss.sprites.inspect
