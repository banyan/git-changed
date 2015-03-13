require "git/modified/version"
require 'contracts'

module Git
  module Modified
    include Contracts
    include Contracts::Modules

    Contract Maybe[String] => nil
    def self.run
      case ARGV.first
      when '-v', '--version'
        version
      else
        modified ARGV.first
      end
    end

    Contract String => nil
    def self.version
      puts Git::Modified::VERSION
    end

    Contract Maybe[String] => nil
    def self.modified(hash = nil)
      if hash.nil?
        show_modified_files_on_working_tree
      else
        show_modified_files_on_commit hash
      end
    end

    Contract nil => nil
    def self.show_modified_files_on_working_tree
      puts `git status --porcelain` \
        .each_line \
        .reject { |line| line[0..1].split('').lazy.any? { |x| x == 'D' } } \
        .map    { |line| line[3..-1] }
    end

    Contract Maybe[String] => nil
    def self.show_modified_files_on_commit(hash)
      hashes = `git show --summary --format="%P" #{hash} | head -n 1`.split ' '

      if hashes.size == 2
        puts `git diff --name-only #{hashes[0]}...#{hashes[1]}`
      else
        puts `git log -m -1 --name-only --pretty="format:" #{hash}`
      end
    end

    Contract nil => String
    def self.latest_hash
      `git log --pretty=format:'%h' -n 1`
    end
  end
end
