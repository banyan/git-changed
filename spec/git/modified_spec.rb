require 'spec_helper'
require 'tmpdir'

describe Git::Modified do
  def first_commit
    Dir.mktmpdir do |dir|
      Dir.chdir dir do
        `touch a.txt`
        `git init`
        `git config --local user.email "you@example.com"`
        `git config --local user.name "Your Name"`
        `git add .`
        `git commit -m "First commit"`
        yield
      end
    end
  end

  describe '.modified' do
    context 'when argument is not passed' do
      context 'when there are no modified files in working trees' do
        it "does not output modified files to stdout" do
          first_commit do
            expect{ Git::Modified.modified }.to output('').to_stdout
          end
        end
      end

      context 'when there are modified files in working trees' do
        it "outputs modified files to stdout" do
          first_commit do
            `touch b.txt`
            `git add .`
            `touch c.txt`

            expect{ Git::Modified.modified }.to output(/b\.txt\nc\.txt/).to_stdout
          end
        end
      end

      context 'when there are deleted files in working trees' do
        context 'when in workspace' do
          it "does not output modified files to stdout" do
            first_commit do
              `rm a.txt`
              expect{ Git::Modified.modified }.to output('').to_stdout
            end
          end
        end

        context 'when in index' do
          it "does not output modified files to stdout" do
            first_commit do
              `rm a.txt`
              `git add -u a.txt`
              expect{ Git::Modified.modified }.to output('').to_stdout
            end
          end
        end
      end

      context 'when there are binary files in working trees' do
        context 'when in workspace' do
          it "does not output binary files to stdout" do
            first_commit do
              `touch a.png`
              expect{ Git::Modified.modified }.to output('').to_stdout
            end
          end
        end

        context 'when in index' do
          it "does not output binary files to stdout" do
            first_commit do
              `touch a.png`
              `git add -u a.png`
              expect{ Git::Modified.modified }.to output('').to_stdout
            end
          end
        end
      end

      context 'when files are renamed' do
        it "outputs renamed file to stdout" do
          first_commit do
            `mv a.txt b.txt`
            expect{ Git::Modified.modified }.to output("b.txt\n").to_stdout
            `git add -A`
            expect{ Git::Modified.modified }.to output("b.txt\n").to_stdout
          end
        end
      end
    end

    context 'when argument is passed' do
      it "outputs modified files to stdout" do
        first_commit do
          expect{ Git::Modified.modified(Git::Modified.latest_hash) }.to output(/a\.txt/).to_stdout
        end
      end
    end

    context 'merge commit' do
      it "outputs modified files to stdout" do
        first_commit do
          `git checkout -b b-txt`
          `touch b.txt`
          `git add .`
          `git commit -m "Add b.txt"`
          `git checkout master`

          `git checkout -b c-txt`
          `touch c.txt`
          `git add .`
          `git commit -m "Add c.txt"`
          `git checkout master`

          `git merge --no-ff c-txt` # Add no-ff option to immitate GitHub pull requests
          `git merge --no-ff b-txt`

          expect{ Git::Modified.modified(Git::Modified.latest_hash) }.to output(/b\.txt/).to_stdout
        end
      end
    end
  end
end
