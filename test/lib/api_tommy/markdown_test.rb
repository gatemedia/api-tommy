require 'test_helper'

module ApiTommy
  class MarkdownTest < ActiveSupport::TestCase
    def setup
      @h = ApiTommy::Markdown
    end

    1.upto(6).each do |level|
      test "can generate an h#{level} title" do
        assert_equal "\n#{'#' * level} foobar\n", @h.send("h#{level}", 'foobar')
      end
    end

    test 'can generate a paragraph' do
      assert_equal "\nfoobar!\n", @h.p('foobar!')
    end

    test 'can generate an unordered list item' do
      assert_equal "* foobar\n", @h.ul('foobar')
    end

    test 'can generate table headers' do
      expected = "\n| foo | bar | foobar \n| --- | --- | --- \n"
      assert_equal expected, @h.th('foo', 'bar', 'foobar')
    end

    test 'can generate table values' do
      assert_equal "| foo | bar | foobar \n", @h.tr('foo', 'bar', 'foobar')
    end
  end
end