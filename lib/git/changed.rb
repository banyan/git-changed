require "git/changed/version"

module Git
  module Changed
    def self.run
      case ARGV.first
      when '-v', '--version'
        version
      else
        changed ARGV.first
      end
    end

    def self.version
      puts Git::Changed::VERSION
    end

    def self.changed(hash = nil)
      hash = latest_hash if hash.nil?
      hashes = `git show --summary --format="%P" #{hash} | head -n 1`.split ' '

      if hashes.size == 2
        puts `git diff --name-only #{hashes[0]}...#{hashes[1]}`
      else
        puts `git log -m -1 --name-only --pretty="format:" #{hash}`
      end
    end

    def self.latest_hash
      `git log --pretty=format:'%h' -n 1`
    end
  end
end
