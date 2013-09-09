require 'versionomy'
require 'rdoc/rdoc'

v = Versionomy.parse(RDoc::VERSION)
require 'rdoc/generator/api_tommy' if v.major == 3 && v.minor >= 9

module ApiTommy

end
