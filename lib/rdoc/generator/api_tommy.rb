class RDoc::Generator::ApiTommy < ApiTommy::Generator
  RDoc::RDoc.add_generator self

  def initialize(store, options)
    @store = store
    @options = options
    @content = ''
    @h = ApiTommy::Markdown
  end

  def generate
    log('Parsing and Generating doc...')
    @store.all_classes.each do |clazz|
      generate_class_doc(clazz)
    end
    log('Done.')

    finalize_content
    update_wiki
  end
end
