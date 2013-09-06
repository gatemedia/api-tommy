require 'api_tomdoc/error'
require 'grit'
require 'tmpdir'

module ApiTomdoc
  class Github
    def update_wiki(file, content)
      Dir.mktmpdir('api_tomdoc') do |dir|
        clone_wiki(dir)
        update_file(dir, file, content)
        push(dir, file)
      end
    rescue => e
      raise Error, "Can't update wiki (#{e.message})"
    end

    def wiki_url
      origin = Grit::Repo.new(Dir.pwd).config['remote.origin.url']
      if origin
        return origin.gsub('.git', '.wiki.git')
      end
    end

    def clone_wiki(dir)
      git = Grit::Git.new('/tmp/filling-in')
      git.clone({}, wiki_url, dir)
    end

    def update_file(dir, file, content)
      File.open(File.join(dir, file), 'w') { |f| f.write(content) }
    end

    def push(dir, file)
      repo = Grit::Repo.new(dir)
      Dir.chdir(dir) { repo.add(file) }
      repo.commit_index("Update #{file}")
      repo.git.push({}, 'origin', 'master')
    end
  end
end