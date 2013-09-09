# file need for rdoc generator auto discovering
require 'versionomy'
require 'rdoc/rdoc'

v = Versionomy.parse(RDoc::VERSION)
require 'api_tomdoc' if v.major == 3 && v.minor >= 9