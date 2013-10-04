class RDoc::Generator::ApiTommy < ApiTommy::Generator
  RDoc::RDoc.add_generator self

  def initialize(options)
    @options = options
    @content = ''
    @h = ApiTommy::Markdown
  end

  def generate(files)
    log('Parsing and Generating doc...')
    files.each do |file|
      file.classes_or_modules.uniq.each do |clazz|
        generate_class_doc(clazz)
      end
    end
    log('Done.')

    finalize_content
    update_wiki
  end
end