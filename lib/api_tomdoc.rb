require 'versionomy'
require 'rdoc/rdoc'

v = Versionomy.parse(RDoc::VERSION)
require 'rdoc/generator/api_tomdoc' if v.major == 3 && v.minor >= 9

module ApiTomdoc

end
