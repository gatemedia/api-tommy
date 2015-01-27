require "grit"
require "tmpdir"

module ApiTommy
  class Github
    def update_wiki(file, content)
      Dir.mktmpdir("api_tommy") do |dir|
        clone_wiki(dir)
        update_file(dir, file, content)
        push(dir, file)
      end
    rescue => e
      raise Error, "Can't update wiki (#{e.message})"
    end

    def wiki_url
      return @wiki_url if defined?(@wiki_url)
      origin = Grit::Repo.new(Dir.pwd).config["remote.origin.url"]
      @wiki_url = origin.gsub(".git", ".wiki.git") if origin
      @wiki_url
    end

    def clone_wiki(dir)
      git = Grit::Git.new("/tmp/filling-in")
      git.clone({}, wiki_url, dir)
    end

    def update_file(dir, file, content)
      File.open(File.join(dir, file), "w") { |f| f.write(content) }
    end

    def push(dir, file)
      repo = Grit::Repo.new(dir)
      Dir.chdir(dir) { repo.add(file) }
      repo.commit_index("Update #{file}")
      repo.git.push({}, "origin", "master")
    end
  end
end
