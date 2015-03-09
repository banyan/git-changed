require "git/changed/version"
require 'contracts'

module Git
  module Changed
    include Contracts
    include Contracts::Modules

    Contract Maybe[String] => nil
    def self.run
      case ARGV.first
      when '-v', '--version'
        version
      else
        changed ARGV.first
      end
    end

    Contract String => nil
    def self.version
      puts Git::Changed::VERSION
    end

    Contract Maybe[String] => nil
    def self.changed(hash = nil)
      if hash.nil?
        show_modified_files_on_working_tree
      else
        show_modified_files_on_commit hash
      end
    end

    Contract nil => nil
    def self.show_modified_files_on_working_tree
      puts `git status --porcelain`.each_line.map { |x| x[3..-1] }
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
