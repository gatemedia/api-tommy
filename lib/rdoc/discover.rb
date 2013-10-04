# file need for rdoc generator auto discovering
require 'versionomy'
require 'rdoc/rdoc'

v = Versionomy.parse(RDoc::VERSION)
require 'api_tommy'