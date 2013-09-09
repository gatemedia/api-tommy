require 'test_helper'
require 'ostruct'
require 'optparse'

class RDoc::Generator::ApiTommyTest < ActiveSupport::TestCase
  def setup
    options = RDoc::Options.new
    options.generator = 'ApiTommy'
    options.verbosity = 0
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTommy.setup_options options

    rdoc = RDoc::RDoc.new
    rdoc.options = options
    @parsing = rdoc.parse_files(['./test/fixtures/samples_controller.rb'])

    @generator = RDoc::Generator::ApiTommy.new(rdoc.options)
  end

  test 'rdoc should have registered the generator' do
    assert_equal RDoc::Generator::ApiTommy, RDoc::RDoc::GENERATORS['apitommy']
  end

  test 'should set corret setup options' do
    options = OpenStruct.new(:dry_run => false, :option_parser => OptionParser.new)
    RDoc::Generator::ApiTommy.setup_options options
    assert options.dry_run
  end

  test 'accepts a filename option' do
    options = RDoc::Options.new
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTommy.setup_options options
    options.option_parser.parse(['--filename', 'foobar.md'])
    assert_equal 'foobar.md', options.filename
  end

  test 'accepts a filename option with space' do
    options = RDoc::Options.new
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTommy.setup_options options
    options.option_parser.parse(['--filename', 'foo bar.md'])
    assert_equal 'foo-bar.md', options.filename
  end

  test 'accepts a filename option without md extension' do
    options = RDoc::Options.new
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTommy.setup_options options
    options.option_parser.parse(['--filename', 'foobar'])
    assert_equal 'foobar.md', options.filename
  end

  test 'accepts a header option' do
    options = RDoc::Options.new
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTommy.setup_options options
    options.option_parser.parse(['--header', 'foobar.md'])
    assert_equal 'foobar.md', options.header
  end

  test 'accepts a footer option' do
    options = RDoc::Options.new
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTommy.setup_options options
    options.option_parser.parse(['--footer', 'foobar.md'])
    assert_equal 'foobar.md', options.footer
  end

  test 'should correctly generate' do
    ApiTommy::Github.any_instance.stubs(:update_wiki)
    @generator.generate(@parsing)
    @generator.content.include?('This API deals with user operations.')
    @generator.content.include?('Get all users.')
  end

  test 'should correctly generate with header and footer' do
    ApiTommy::Github.any_instance.stubs(:update_wiki)
    @generator.options.header = 'test/fixtures/header.md'
    @generator.options.footer = 'test/fixtures/footer.md'
    @generator.generate(@parsing)

    assert @generator.content.include?('This is the header')
    assert @generator.content.include?('This is the footer')
  end
end

class RDoc::Generator::ApiTommy
  attr_accessor :options, :content
end