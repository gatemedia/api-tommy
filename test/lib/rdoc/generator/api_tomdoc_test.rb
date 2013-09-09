require 'test_helper'
require 'ostruct'
require 'optparse'

class RDoc::Generator::ApiTomdoc < ActiveSupport::TestCase

  def setup
    options = RDoc::Options.new
    options.generator = 'apitomdoc'
    options.verbosity = 0
    options.option_parser = OptionParser.new
    RDoc::Generator::ApiTomDoc.setup_options options

    rdoc = RDoc::RDoc.new
    rdoc.options = options
    @parsing = rdoc.parse_files(['./test/fixtures/samples_controller.rb'])

    @generator = RDoc::Generator::ApiTomDoc.new(rdoc.options)
  end

  test 'rdoc should have registered the generator' do
    assert_equal RDoc::Generator::ApiTomDoc, RDoc::RDoc::GENERATORS['apitomdoc']
  end

  test 'should set corret setup options' do
    options = OpenStruct.new(:dry_run => false, :option_parser => OptionParser.new)
    RDoc::Generator::ApiTomDoc.setup_options options
    assert options.dry_run
  end

  test 'should correctly generate' do
    ApiTomdoc::Github.any_instance.stubs(:update_wiki)
    @generator.generate(@parsing)
  end

end