require 'rdoc/rdoc'
require 'tomparse'

require 'api_tomdoc/markdown'
require 'api_tomdoc/github'

class RDoc::Generator::ApiTomDoc
  RDoc::RDoc.add_generator self

  def self.setup_options options
    options.dry_run = true
    op = options.option_parser

    op.on('--filename FILENAME', String, 'The output filename') do |filename|
      options.filename = filename.gsub(/\s+/, '-')
      options.filename = "#{options.filename}.md" unless options.filename.end_with?('.md')
    end

    op.on('--header HEADER', String, 'The header filename') do |header|
      options.header = header
    end

    op.on('--footer FOOTER', String, 'The footer filename') do |footer|
      options.footer = footer
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

    @content = "#{File.read(@options.header)}\n#{@content}" if @options.header
    @content << File.read(@options.footer) if @options.footer

    FileUtils.cd(Dir.pwd.end_with?('/doc')? '..' : Dir.pwd) do
      ApiTomdoc::Github.new.update_wiki(@options.filename || 'API.md', @content)
    end
  end

  private

  def generate_class_doc(clazz)
    generate_class_header(clazz)
    clazz.instance_method_list.each { |method| generate_method_doc(method) }
  end

  def generate_class_header(clazz)
    @content << @h.h1(clazz.name.gsub(/Controller/, ''))
    @tomdoc = TomParse.parse(comment(clazz).split('---').first)
    @content << @h.p(@tomdoc.description)

    arguments('Fields')
    examples
  end

  def generate_method_doc(method)
    @tomdoc = TomParse.parse(comment(method))
    @content << @h.h2(@tomdoc.description.split('.').first)
    @content << @h.p(@tomdoc.description)

    returns
    arguments
    examples
    raises
  end

  def arguments(title = 'Parameters')
    unless @tomdoc.arguments.empty?
      @content << @h.h3(title)
      @content << @h.th('Name', 'Description')
      @tomdoc.arguments.each do |a|
        @content << @h.tr(a.name.to_s, a.description)
      end
    end
  end

  def examples
    unless @tomdoc.examples.empty?
      @content << @h.h3('Examples')
      @tomdoc.examples.each do |e|
        @content << @h.code(e.to_s)
      end
    end
  end

  def returns
    unless @tomdoc.returns.empty?
      @tomdoc.returns.each do |r|
        @content << @h.p(r.to_s)
      end
    end
  end

  def raises
    unless @tomdoc.raises.empty?
      @content << @h.h3('Errors')
      @tomdoc.raises.each do |r|
        @content << @h.p(r.to_s.gsub(/Raises\s/, ''))
      end
    end
  end

  def comment(object)
    result = object.comment
    return result if result.is_a?(String)
    result.text
  end
end

# Monkey patch to add accessors
class RDoc::Options
  attr_accessor :filename, :header, :footer
end