require 'versionomy'
require 'rdoc/rdoc'
require 'api_tommy/version'
require 'api_tommy/error'
require 'api_tommy/markdown'
require 'api_tommy/github'
require 'api_tommy/generator'

v = Versionomy.parse(RDoc::VERSION)
require 'rdoc/generator/api_tommy3' if v.major == 3 && v.minor >= 9
require 'rdoc/generator/api_tommy4' if v.major == 4

module ApiTommy

end
