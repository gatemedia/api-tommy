require 'test_helper'
require 'tmpdir'

module ApiTomdoc
  class GithubTest < ActiveSupport::TestCase

    def setup
      @g = Github.new
    end

    test 'can extract wiki url' do
      Grit::Repo.any_instance.expects(:config).returns('remote.origin.url' => 'foobar.git')
      assert_equal 'foobar.wiki.git', @g.wiki_url
    end

    test 'can clone a github wiki' do
      Grit::Repo.any_instance.stubs(:config).returns('remote.origin.url' => 'https://github.com/rails-api/rails-api.git')
      Dir.mktmpdir('api_tomdoc') do |dir|
        Grit::Git.any_instance.expects(:clone).with('https://github.com/rails-api/rails-api.wiki.git', dir)
        @g.clone_wiki(dir)
      end
    end

    test 'can update a file' do
      filename = 'foobar.txt'
      Dir.mktmpdir('api_tomdoc') do |dir|
        Dir.chdir(dir) { File.open(filename, 'w') { |f| f.write('foo')} }
        @g.update_file(dir, filename, 'bar')
        Dir.chdir(dir) { assert_equal 'bar', File.read(filename) }
      end
    end

    test 'can push file' do
      filename = 'foobar.txt'
      Dir.mktmpdir(['api_tomdoc', '.git']) do |dir|
        repo = Grit::Repo.new(dir)
        @g.update_file(dir, filename, 'foo')
        Grit::Git.any_instance.stubs(:push).with('origin', 'master')
        @g.push(dir, filename)
      end
    end
  end
end