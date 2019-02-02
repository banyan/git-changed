require "git/modified/version"

module Git
  module Modified
    def self.run
      case ARGV.first
      when '-v', '--version'
        version
      else
        modified ARGV.first
      end
    end

    def self.version
      puts Git::Modified::VERSION
    end

    def self.modified(hash = nil)
      if hash.nil?
        show_modified_files_on_working_tree
      else
        show_modified_files_on_commit hash
      end
    end

    def self.show_modified_files_on_working_tree
      puts `git status --short` \
        .each_line \
        .reject { |line| line[0..1].split('').lazy.any? { |x| x == 'D' } } \
        .reject { |line| line.match /\.(jpe?g|png|gif|svg|eot|mp3|ttf|wav|wof)$/i } \
        .map    { |line| if line[0] == 'R' then line.split(' ')[-1] else line[3..-1] end }
    end

    def self.show_modified_files_on_commit(hash)
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
