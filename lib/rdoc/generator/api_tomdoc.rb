require 'rdoc/rdoc'
require 'tomparse'

require 'api_tomdoc/markdown'
require 'api_tomdoc/github'

class RDoc::Generator::ApiTomDoc
  RDoc::RDoc.add_generator self

  def self.setup_options options
    options.dry_run = true
    op = options.option_parser
    op.on('--filename FILENAME', String, 'Mandatory filename') do |filename|
      @filename = filename
    end
  end

  def initialize(options)
    @options = options
    @content = ''
    @h = ApiTomdoc::Markdown
  end

  def generate(files)
    files.each do |file|
      file.classes_or_modules.uniq.each do |clazz|
        generate_class_doc(clazz)
      end
    end

    FileUtils.cd(Dir.pwd.end_with?('/doc')? '..' : Dir.pwd) do
      ApiTomdoc::Github.new.update_wiki(@filename || 'API.md', @content)
    end
  end

  private

  def generate_class_doc(clazz)
    generate_class_header(clazz)
    clazz.instance_method_list.each { |method| generate_method_doc(method) }
  end

  def generate_class_header(clazz)
    @content << @h.h1(clazz.name.gsub(/Controller/, ''))
    tomdoc = TomParse.parse(clazz.comment.split('---').first)

    @content << @h.p(tomdoc.description)

    unless tomdoc.arguments.empty?
      @content << @h.h3('Fields')
      @content << @h.th('Name', 'Description')
      tomdoc.arguments.each do |a|
        @content << @h.tr(a.name.to_s, a.description)
      end
    end

    unless tomdoc.examples.empty?
      @content << @h.h3('Examples')
      tomdoc.examples.each do |e|
        @content << @h.code(e.to_s)
      end
    end
  end

  def generate_method_doc(method)
    tomdoc = TomParse.parse(method.comment)

    @content << @h.h2(tomdoc.description.split('.').first)
    @content << @h.p(tomdoc.description)

    unless tomdoc.returns.empty?
      tomdoc.returns.each do |r|
        @content << @h.p(r.to_s)
      end
    end

    unless tomdoc.arguments.empty?
      @content << @h.h3('Parameters')
      @content << @h.th('Name', 'Description')
      tomdoc.arguments.each do |a|
        @content << @h.tr(a.name.to_s, a.description)
      end
    end

    unless tomdoc.examples.empty?
      @content << @h.h3('Examples')
      tomdoc.examples.each do |e|
        @content << @h.code(e.to_s)
      end
    end

    unless tomdoc.raises.empty?
      @content << @h.h3('Errors')
      tomdoc.raises.each do |r|
        @content << @h.p(r.to_s.gsub(/Raises\s/, ''))
      end
    end
  end
end